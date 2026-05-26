import '../../../../shared/models/transaction.dart';

abstract class TransactionRepository {
  Stream<List<Transaction>> watchAll();
  Stream<List<Transaction>> watchByMonth(DateTime month);
  Stream<List<Transaction>> watchByCategory(String categoryId);
  Future<List<Transaction>> getByDateRange(DateTime start, DateTime end);
  Future<Transaction?> getById(String id);
  Future<void> add(Transaction transaction);
  Future<void> update(Transaction transaction);
  Future<void> delete(String id);
  Future<double> totalSpentForMonth(DateTime month);
  Future<double> totalIncomeForMonth(DateTime month);
  Future<double> todaySpending();
  Future<double> weekSpending();
  Future<Map<String, double>> spendingByCategoryForMonth(DateTime month);
}
