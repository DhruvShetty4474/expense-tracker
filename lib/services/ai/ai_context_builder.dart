import '../../core/database/app_database.dart';
import '../../shared/enums/transaction_type.dart';
import 'ai_provider_interface.dart';

/// Builds a sanitized FinancialContext from local DB — never exposes raw SMS,
/// account numbers, OTPs, or any personally identifiable financial data.
class AiContextBuilder {
  final AppDatabase _db;

  AiContextBuilder(this._db);

  Future<FinancialContext> build({
    required DateTime month,
    required String userQuery,
  }) async {
    final monthStart = DateTime(month.year, month.month, 1);
    final monthEnd = DateTime(month.year, month.month + 1, 0, 23, 59, 59);

    final all = await _db.select(_db.transactionsTable).get();
    final txns = all.where((t) =>
        !t.timestamp.isBefore(monthStart) &&
        !t.timestamp.isAfter(monthEnd)).toList();

    double totalIncome = 0;
    double totalSpent = 0;
    final categorySpend = <String, double>{};
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
        if (t.merchant != null) merchants.add(t.merchant!);
      }
    }

    final savingsRate =
        totalIncome > 0 ? ((totalIncome - totalSpent) / totalIncome).clamp(0, 1) : 0.0;

    // Fetch category names to replace IDs
    final categories = await _db.select(_db.categoriesTable).get();
    final catMap = {for (final c in categories) c.id: c.name};
    final namedSpend = categorySpend.map(
      (id, amount) => MapEntry(catMap[id] ?? id, amount),
    );

    return FinancialContext(
      monthlyIncome: totalIncome,
      totalSpentThisMonth: totalSpent,
      spendingByCategory: namedSpend,
      recentMerchants: merchants.take(15).toList(),
      savingsRate: savingsRate.toDouble(),
      userQuery: userQuery,
    );
  }
}
