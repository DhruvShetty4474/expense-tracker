import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../app/di/providers.dart';
import '../../../../shared/models/budget.dart';
import '../../../../shared/models/category.dart';
import '../../../transactions/presentation/providers/transaction_providers.dart';
import '../../data/repositories/budget_repository_impl.dart';
import '../../domain/repositories/budget_repository.dart';

final budgetRepositoryProvider = Provider<BudgetRepository>((ref) {
  return BudgetRepositoryImpl(ref.watch(databaseProvider));
});

int _yyyymm(DateTime d) => d.year * 100 + d.month;

final currentBudgetsProvider = StreamProvider<List<Budget>>((ref) {
  ref.watch(currentMonthTransactionsProvider); // refresh on new txns
  return ref.watch(budgetRepositoryProvider).watchByMonth(_yyyymm(DateTime.now()));
});

// Budget alert: budgets that have exceeded their alertAt threshold
final budgetAlertsProvider = Provider<List<Budget>>((ref) {
  final budgets = ref.watch(currentBudgetsProvider).valueOrNull ?? [];
  return budgets.where((b) => b.percentUsed >= b.alertAt).toList();
});

// Enriched budgets with category info
final enrichedBudgetsProvider =
    Provider<List<({Budget budget, Category? category})>>((ref) {
  final budgets = ref.watch(currentBudgetsProvider).valueOrNull ?? [];
  final cats = ref.watch(categoriesProvider).valueOrNull ?? [];
  return budgets.map((b) {
    final cat = cats.cast<Category?>().firstWhere(
          (c) => c?.id == b.categoryId,
          orElse: () => null,
        );
    return (budget: b, category: cat);
  }).toList();
});

class BudgetNotifier extends Notifier<void> {
  @override
  void build() {}

  Future<void> upsert({
    String? existingId,
    required String categoryId,
    required double amount,
    double alertAt = 0.9,
  }) async {
    final now = DateTime.now();
    await ref.read(budgetRepositoryProvider).upsert(Budget(
          id: existingId ?? const Uuid().v4(),
          categoryId: categoryId,
          month: _yyyymm(now),
          amount: amount,
          alertAt: alertAt,
        ));
  }

  Future<void> updateSpent(String id, double spent) async {
    final budgets = ref.read(currentBudgetsProvider).valueOrNull ?? [];
    final b = budgets.firstWhere((b) => b.id == id);
    await ref.read(budgetRepositoryProvider).upsert(b.copyWith(spent: spent));
  }

  Future<void> delete(String id) =>
      ref.read(budgetRepositoryProvider).delete(id);
}

final budgetNotifierProvider =
    NotifierProvider<BudgetNotifier, void>(BudgetNotifier.new);
