import 'package:drift/drift.dart' hide Column;
import '../../../../core/database/app_database.dart';
import '../../../../shared/models/budget.dart';
import '../../domain/repositories/budget_repository.dart';

class BudgetRepositoryImpl implements BudgetRepository {
  final AppDatabase _db;
  BudgetRepositoryImpl(this._db);

  Budget _fromRow(BudgetsTableData r) => Budget(
        id: r.id,
        categoryId: r.categoryId,
        month: r.month,
        amount: r.amount,
        spent: r.spent,
        alertAt: r.alertAt,
      );

  @override
  Stream<List<Budget>> watchByMonth(int yyyymm) =>
      (_db.select(_db.budgetsTable)..where((t) => t.month.equals(yyyymm)))
          .watch()
          .map((rows) => rows.map(_fromRow).toList());

  @override
  Future<void> upsert(Budget budget) => _db
      .into(_db.budgetsTable)
      .insertOnConflictUpdate(BudgetsTableCompanion(
        id: Value(budget.id),
        categoryId: Value(budget.categoryId),
        month: Value(budget.month),
        amount: Value(budget.amount),
        spent: Value(budget.spent),
        alertAt: Value(budget.alertAt),
      ));

  @override
  Future<void> delete(String id) =>
      (_db.delete(_db.budgetsTable)..where((t) => t.id.equals(id))).go();
}
