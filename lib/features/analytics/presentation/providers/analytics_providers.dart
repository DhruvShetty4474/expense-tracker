import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/models/category.dart';
import '../../../transactions/presentation/providers/transaction_providers.dart';

// Spending by category for the current month, enriched with category names
final categorySpendingEnrichedProvider =
    Provider<List<({Category category, double amount, double pct})>>((ref) {
  final spending = ref.watch(categorySpendingProvider).valueOrNull ?? {};
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

// Daily spending for last 30 days
final dailySpendingProvider =
    Provider<List<({DateTime date, double amount})>>((ref) {
  final txns = ref.watch(allTransactionsProvider).valueOrNull ?? [];
  final now = DateTime.now();
  final cutoff = now.subtract(const Duration(days: 30));

  final map = <String, double>{};
  for (final t in txns) {
    if (t.timestamp.isBefore(cutoff)) continue;
    final key =
        '${t.timestamp.year}-${t.timestamp.month}-${t.timestamp.day}';
    map.update(key, (v) => v + t.amount, ifAbsent: () => t.amount);
  }

  final result = <({DateTime date, double amount})>[];
  for (int i = 29; i >= 0; i--) {
    final d = now.subtract(Duration(days: i));
    final key = '${d.year}-${d.month}-${d.day}';
    result.add((date: d, amount: map[key] ?? 0));
  }
  return result;
});
