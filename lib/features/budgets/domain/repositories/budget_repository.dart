import '../../../../shared/models/budget.dart';

abstract class BudgetRepository {
  Stream<List<Budget>> watchByMonth(int yyyymm);
  Future<void> upsert(Budget budget);
  Future<void> delete(String id);
}
