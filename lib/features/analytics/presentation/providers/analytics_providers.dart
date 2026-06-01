import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../services/storage/storage_estimator.dart';
import '../../../../shared/enums/transaction_type.dart';
import '../../../../shared/models/category.dart';
import '../../../budgets/presentation/providers/budget_providers.dart';
import '../../../transactions/presentation/providers/transaction_providers.dart';

/// Selected month for analytics (defaults to now).
final analyticsMonthProvider = StateProvider<DateTime>(
  (ref) => DateTime(DateTime.now().year, DateTime.now().month),
);

int _yyyymm(DateTime d) => d.year * 100 + d.month;

final analyticsMonthSpendingProvider = FutureProvider<double>((ref) async {
  final month = ref.watch(analyticsMonthProvider);
  final repo = ref.read(transactionRepositoryProvider);
  return repo.totalSpentForMonth(month);
});

final analyticsMonthIncomeProvider = FutureProvider<double>((ref) async {
  final month = ref.watch(analyticsMonthProvider);
  final repo = ref.read(transactionRepositoryProvider);
  return repo.totalIncomeForMonth(month);
});

final analyticsPrevMonthSpendingProvider = FutureProvider<double>((ref) async {
  final month = ref.watch(analyticsMonthProvider);
  final prev = DateTime(month.year, month.month - 1);
  final repo = ref.read(transactionRepositoryProvider);
  return repo.totalSpentForMonth(prev);
});

final analyticsCategorySpendingProvider =
    FutureProvider<Map<String, double>>((ref) async {
  final month = ref.watch(analyticsMonthProvider);
  final repo = ref.read(transactionRepositoryProvider);
  return repo.spendingByCategoryForMonth(month);
});

final categorySpendingEnrichedProvider =
    Provider<List<({Category category, double amount, double pct})>>((ref) {
  final spending =
      ref.watch(analyticsCategorySpendingProvider).valueOrNull ?? {};
  final cats = ref.watch(categoriesProvider).valueOrNull ?? [];
  if (spending.isEmpty) return [];

  final total = spending.values.fold<double>(0, (a, b) => a + b);
  final result = <({Category category, double amount, double pct})>[];

  for (final entry in spending.entries) {
    final cat = cats.cast<Category?>().firstWhere(
          (c) => c?.id == entry.key,
          orElse: () => null,
        );
    if (cat != null) {
      result.add((
        category: cat,
        amount: entry.value,
        pct: total > 0 ? entry.value / total : 0,
      ));
    }
  }

  result.sort((a, b) => b.amount.compareTo(a.amount));
  return result;
});

/// Daily **debit** spending for the 30 days ending on the selected month’s last day.
final dailySpendingProvider =
    Provider<List<({DateTime date, double amount})>>((ref) {
  final txns = ref.watch(allTransactionsProvider).valueOrNull ?? [];
  final month = ref.watch(analyticsMonthProvider);
  final end = DateTime(month.year, month.month + 1, 0);
  final start = end.subtract(const Duration(days: 29));

  final map = <String, double>{};
  for (final t in txns) {
    if (t.type != TransactionType.debit) continue;
    if (t.timestamp.isBefore(start) || t.timestamp.isAfter(end)) continue;
    final key = '${t.timestamp.year}-${t.timestamp.month}-${t.timestamp.day}';
    map.update(key, (v) => v + t.amount, ifAbsent: () => t.amount);
  }

  final result = <({DateTime date, double amount})>[];
  for (int i = 0; i < 30; i++) {
    final d = start.add(Duration(days: i));
    final key = '${d.year}-${d.month}-${d.day}';
    result.add((date: d, amount: map[key] ?? 0));
  }
  return result;
});

final topMerchantsProvider =
    Provider<List<({String name, double amount, int count})>>((ref) {
  final month = ref.watch(analyticsMonthProvider);
  final txns = ref.watch(allTransactionsProvider).valueOrNull ?? [];
  final monthStart = DateTime(month.year, month.month, 1);
  final monthEnd = DateTime(month.year, month.month + 1, 0, 23, 59, 59);

  final map = <String, ({double amount, int count})>{};
  for (final t in txns) {
    if (t.type != TransactionType.debit) continue;
    if (t.timestamp.isBefore(monthStart) || t.timestamp.isAfter(monthEnd)) {
      continue;
    }
    final m = t.merchant?.trim();
    if (m == null || m.isEmpty) continue;
    final cur = map[m];
    map[m] = (
      amount: (cur?.amount ?? 0) + t.amount,
      count: (cur?.count ?? 0) + 1,
    );
  }

  return map.entries
      .map((e) => (name: e.key, amount: e.value.amount, count: e.value.count))
      .toList()
    ..sort((a, b) => b.amount.compareTo(a.amount));
});

final budgetVsActualProvider =
    Provider<List<({Category? category, double budget, double spent, double pct})>>((ref) {
  final month = ref.watch(analyticsMonthProvider);
  final budgetsAsync = ref.watch(currentBudgetsProvider);
  final spending =
      ref.watch(analyticsCategorySpendingProvider).valueOrNull ?? {};
  final cats = ref.watch(categoriesProvider).valueOrNull ?? [];

  if (_yyyymm(month) != _yyyymm(DateTime.now())) {
    // Budget table is month-keyed; only show for current month for now
    return [];
  }

  final budgets = budgetsAsync.valueOrNull ?? [];
  return budgets.map((b) {
    final cat = cats.cast<Category?>().firstWhere(
          (c) => c?.id == b.categoryId,
          orElse: () => null,
        );
    final spent = spending[b.categoryId] ?? 0;
    return (
      category: cat,
      budget: b.amount,
      spent: spent,
      pct: b.amount > 0 ? (spent / b.amount).clamp(0.0, 1.5) : 0.0,
    );
  }).toList()
    ..sort((a, b) => b.pct.compareTo(a.pct));
});

final storageEstimateProvider = Provider<StorageEstimate>((ref) {
  final count = ref.watch(allTransactionsProvider).valueOrNull?.length ?? 0;
  return StorageEstimator.estimate(transactionCount: count);
});
