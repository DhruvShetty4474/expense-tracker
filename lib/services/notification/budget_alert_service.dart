import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/budgets/presentation/providers/budget_providers.dart';
import '../../features/transactions/presentation/providers/transaction_providers.dart';
import '../../shared/models/budget.dart';
import 'local_notification_service.dart';

// Watches transactions and fires notifications when a budget threshold is crossed
class BudgetAlertService {
  final Ref _ref;
  final Set<String> _notified = {};

  BudgetAlertService(this._ref) {
    // Watch category spending and compare to budgets whenever transactions change
    _ref.listen<AsyncValue<List>>(
      currentMonthTransactionsProvider,
      (_, next) => next.whenData((_) => _check()),
    );
  }

  Future<void> _check() async {
    final categorySpending =
        await _ref.read(transactionRepositoryProvider).spendingByCategoryForMonth(DateTime.now());
    final budgets = _ref.read(currentBudgetsProvider).valueOrNull ?? [];
    final cats = _ref.read(categoriesProvider).valueOrNull ?? [];

    for (final budget in budgets) {
      final spent = categorySpending[budget.categoryId] ?? 0;
      final updated = budget.copyWith(spent: spent);

      // Only notify if threshold exceeded and we haven't notified this month yet
      final key = '${budget.id}_${_thresholdKey(updated)}';
      if (updated.percentUsed >= budget.alertAt && !_notified.contains(key)) {
        _notified.add(key);
        final cat = cats.cast().firstWhere(
          (c) => c?.id == budget.categoryId,
          orElse: () => null,
        );
        final catName = cat?.name ?? budget.categoryId;
        await LocalNotificationService.instance.showBudgetAlert(
          categoryName: catName,
          percentUsed: updated.percentUsed,
          spent: spent,
          budget: budget.amount,
        );
      }
    }
  }

  String _thresholdKey(Budget b) {
    if (b.percentUsed >= 1.0) return 'over';
    if (b.percentUsed >= 0.9) return '90';
    return 'ok';
  }
}

final budgetAlertServiceProvider = Provider<BudgetAlertService>((ref) {
  return BudgetAlertService(ref);
});
