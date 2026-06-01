import '../../core/database/app_database.dart';
import '../../shared/enums/transaction_type.dart';
import 'ai_provider_interface.dart';

/// Builds a sanitized FinancialContext from local DB — never exposes raw SMS,
/// account numbers, OTPs, or any personally identifiable financial data.
class AiContextBuilder {
  final AppDatabase _db;

  AiContextBuilder(this._db);

  int _yyyymm(DateTime d) => d.year * 100 + d.month;

  Future<FinancialContext> build({
    required DateTime month,
    required String userQuery,
  }) async {
    final monthStart = DateTime(month.year, month.month, 1);
    final monthEnd = DateTime(month.year, month.month + 1, 0, 23, 59, 59);

    final prevMonth = DateTime(month.year, month.month - 1, 1);
    final prevStart = DateTime(prevMonth.year, prevMonth.month, 1);
    final prevEnd = DateTime(prevMonth.year, prevMonth.month + 1, 0, 23, 59, 59);

    final all = await _db.select(_db.transactionsTable).get();
    final txns = all.where((t) =>
        !t.timestamp.isBefore(monthStart) &&
        !t.timestamp.isAfter(monthEnd)).toList();

    final prevTxns = all.where((t) =>
        !t.timestamp.isBefore(prevStart) &&
        !t.timestamp.isAfter(prevEnd)).toList();

    double totalIncome = 0;
    double totalSpent = 0;
    double previousMonthSpent = 0;
    final categorySpend = <String, double>{};
    final merchantSpend = <String, double>{};
    final merchants = <String>{};

    for (final t in txns) {
      if (t.type == TransactionType.credit) {
        totalIncome += t.amount;
      } else {
        totalSpent += t.amount;
        categorySpend.update(
          t.categoryId,
          (v) => v + t.amount,
          ifAbsent: () => t.amount,
        );
        if (t.merchant != null) {
          merchants.add(t.merchant!);
          merchantSpend.update(
            t.merchant!,
            (v) => v + t.amount,
            ifAbsent: () => t.amount,
          );
        }
      }
    }

    for (final t in prevTxns) {
      if (t.type == TransactionType.debit) {
        previousMonthSpent += t.amount;
      }
    }

    final savingsRate = totalIncome > 0
        ? ((totalIncome - totalSpent) / totalIncome).clamp(0, 1)
        : 0.0;

    final categories = await _db.select(_db.categoriesTable).get();
    final catMap = {for (final c in categories) c.id: c.name};
    final namedSpend = categorySpend.map(
      (id, amount) => MapEntry(catMap[id] ?? id, amount),
    );

    final sortedMerchants = merchantSpend.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final topMerchants = Map.fromEntries(
      sortedMerchants.take(8).map((e) => MapEntry(e.key, e.value)),
    );

    final budgets = await (_db.select(_db.budgetsTable)
          ..where((b) => b.month.equals(_yyyymm(month))))
        .get();

    final budgetVsActual = <String, ({double budget, double spent})>{};
    for (final b in budgets) {
      final spent = categorySpend[b.categoryId] ?? 0;
      budgetVsActual[catMap[b.categoryId] ?? b.categoryId] = (
        budget: b.amount,
        spent: spent,
      );
    }

    return FinancialContext(
      monthlyIncome: totalIncome,
      totalSpentThisMonth: totalSpent,
      previousMonthSpent: previousMonthSpent,
      spendingByCategory: namedSpend,
      recentMerchants: merchants.take(15).toList(),
      topMerchants: topMerchants,
      savingsRate: savingsRate.toDouble(),
      budgetVsActual: budgetVsActual,
      userQuery: userQuery,
    );
  }
}
