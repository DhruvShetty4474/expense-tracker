import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../app/di/providers.dart';
import '../../../../shared/enums/transaction_source.dart';
import '../../../../shared/enums/transaction_type.dart';
import '../../../../shared/models/category.dart';
import '../../../../shared/models/transaction.dart';
import '../../data/repositories/transaction_repository_impl.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../../../../services/sync/sync_providers.dart';
import '../../../../services/sms/merchant_category_resolver.dart';

// ── Repository ────────────────────────────────────────────────────────────

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return TransactionRepositoryImpl(db);
});

// ── Current month transactions (stream) ──────────────────────────────────

final currentMonthTransactionsProvider =
    StreamProvider<List<Transaction>>((ref) {
  final repo = ref.watch(transactionRepositoryProvider);
  return repo.watchByMonth(DateTime.now());
});

// ── All transactions (stream) ─────────────────────────────────────────────

final allTransactionsProvider = StreamProvider<List<Transaction>>((ref) {
  final repo = ref.watch(transactionRepositoryProvider);
  return repo.watchAll();
});

// ── Home screen aggregates ────────────────────────────────────────────────

final todaySpendingProvider = FutureProvider<double>((ref) {
  ref.watch(currentMonthTransactionsProvider); // re-run on new transactions
  return ref.read(transactionRepositoryProvider).todaySpending();
});

final weekSpendingProvider = FutureProvider<double>((ref) {
  ref.watch(currentMonthTransactionsProvider);
  return ref.read(transactionRepositoryProvider).weekSpending();
});

final monthlySpendingProvider = FutureProvider<double>((ref) {
  ref.watch(currentMonthTransactionsProvider);
  return ref
      .read(transactionRepositoryProvider)
      .totalSpentForMonth(DateTime.now());
});

final monthlyIncomeProvider = FutureProvider<double>((ref) {
  ref.watch(currentMonthTransactionsProvider);
  return ref
      .read(transactionRepositoryProvider)
      .totalIncomeForMonth(DateTime.now());
});

// ── Category spending (for analytics) ────────────────────────────────────

final categorySpendingProvider =
    FutureProvider<Map<String, double>>((ref) {
  ref.watch(currentMonthTransactionsProvider);
  return ref
      .read(transactionRepositoryProvider)
      .spendingByCategoryForMonth(DateTime.now());
});

// ── Categories stream ────────────────────────────────────────────────────

final categoriesProvider = StreamProvider<List<Category>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.categoriesTable).watch().map(
        (rows) => rows
            .map((r) => Category(
                  id: r.id,
                  name: r.name,
                  icon: r.icon,
                  color: r.color,
                  isCustom: r.isCustom,
                  parentId: r.parentId,
                ))
            .toList(),
      );
});

final merchantCategoryResolverProvider = Provider<MerchantCategoryResolver>((ref) {
  final db = ref.watch(databaseProvider);
  return MerchantCategoryResolver(db);
});

// ── Add transaction use-case ──────────────────────────────────────────────

class TransactionFormNotifier extends Notifier<void> {
  @override
  void build() {}

  Future<void> add({
    required double amount,
    required TransactionType type,
    required String categoryId,
    required DateTime timestamp,
    String? merchant,
    String? note,
    List<String> tags = const [],
  }) async {
    final repo = ref.read(transactionRepositoryProvider);
    final txn = Transaction(
      id: const Uuid().v4(),
      amount: amount,
      type: type,
      categoryId: categoryId,
      timestamp: timestamp,
      source: TransactionSource.manual,
      merchant: merchant,
      note: note,
      tags: tags,
    );
    await repo.add(txn);
    if (merchant != null && merchant.trim().isNotEmpty) {
      await ref
          .read(merchantCategoryResolverProvider)
          .saveMapping(merchant, categoryId);
    }
    await ref.read(syncStatusProvider.notifier).pushAfterChange();
  }

  Future<void> edit(Transaction updated) async {
    final repo = ref.read(transactionRepositoryProvider);
    await repo.update(updated);
    await ref.read(merchantCategoryResolverProvider).learnFromTransaction(updated);
    await ref.read(syncStatusProvider.notifier).pushAfterChange();
  }

  Future<void> remove(String id) async {
    final repo = ref.read(transactionRepositoryProvider);
    final sync = ref.read(firestoreSyncServiceProvider);
    await repo.delete(id);
    await sync.pushDelete(id);
  }
}

final transactionFormProvider =
    NotifierProvider<TransactionFormNotifier, void>(
  TransactionFormNotifier.new,
);
