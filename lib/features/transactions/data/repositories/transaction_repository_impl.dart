import 'dart:convert';
import 'package:drift/drift.dart' hide Column, JsonKey;
import '../../../../core/database/app_database.dart';
import '../../../../shared/enums/transaction_type.dart';
import '../../../../shared/models/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final AppDatabase _db;
  TransactionRepositoryImpl(this._db);

  // ── Helpers ──────────────────────────────────────────────────────────────

  Transaction _fromRow(TransactionsTableData r) => Transaction(
        id: r.id,
        amount: r.amount,
        type: r.type,
        categoryId: r.categoryId,
        timestamp: r.timestamp,
        source: r.source,
        merchant: r.merchant,
        note: r.note,
        tags: r.tags.isEmpty ? [] : List<String>.from(jsonDecode(r.tags)),
        refNumber: r.refNumber,
        isRecurring: r.isRecurring,
        recurringId: r.recurringId,
        synced: r.synced,
      );

  TransactionsTableCompanion _toCompanion(Transaction t) =>
      TransactionsTableCompanion(
        id: Value(t.id),
        amount: Value(t.amount),
        type: Value(t.type),
        categoryId: Value(t.categoryId),
        timestamp: Value(t.timestamp),
        source: Value(t.source),
        merchant: Value(t.merchant),
        note: Value(t.note),
        tags: Value(jsonEncode(t.tags)),
        refNumber: Value(t.refNumber),
        isRecurring: Value(t.isRecurring),
        recurringId: Value(t.recurringId),
        synced: Value(t.synced),
      );

  // ── Streams ───────────────────────────────────────────────────────────────

  @override
  Stream<List<Transaction>> watchAll() => (_db.select(_db.transactionsTable)
        ..orderBy([(t) => OrderingTerm.desc(t.timestamp)]))
      .watch()
      .map((rows) => rows.map(_fromRow).toList());

  @override
  Stream<List<Transaction>> watchByMonth(DateTime month) {
    final start = DateTime(month.year, month.month, 1);
    final end = DateTime(month.year, month.month + 1, 0, 23, 59, 59);
    return (_db.select(_db.transactionsTable)
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)]))
        .watch()
        .map((rows) => rows
            .where((r) =>
                !r.timestamp.isBefore(start) && !r.timestamp.isAfter(end))
            .map(_fromRow)
            .toList());
  }

  @override
  Stream<List<Transaction>> watchByCategory(String categoryId) =>
      (_db.select(_db.transactionsTable)
            ..where((t) => t.categoryId.equals(categoryId))
            ..orderBy([(t) => OrderingTerm.desc(t.timestamp)]))
          .watch()
          .map((rows) => rows.map(_fromRow).toList());

  // ── One-shot reads ─────────────────────────────────────────────────────

  @override
  Future<List<Transaction>> getByDateRange(
      DateTime start, DateTime end) async {
    final rows = await (_db.select(_db.transactionsTable)
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)]))
        .get();
    return rows
        .where((r) =>
            !r.timestamp.isBefore(start) && !r.timestamp.isAfter(end))
        .map(_fromRow)
        .toList();
  }

  @override
  Future<Transaction?> getById(String id) async {
    final row = await (_db.select(_db.transactionsTable)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _fromRow(row);
  }

  // ── Writes ────────────────────────────────────────────────────────────────

  @override
  Future<void> add(Transaction transaction) =>
      _db.into(_db.transactionsTable).insert(_toCompanion(transaction));

  @override
  Future<void> update(Transaction transaction) =>
      (_db.update(_db.transactionsTable)
            ..where((t) => t.id.equals(transaction.id)))
          .write(_toCompanion(transaction.copyWith(synced: false)));

  @override
  Future<void> delete(String id) =>
      (_db.delete(_db.transactionsTable)
            ..where((t) => t.id.equals(id)))
          .go();

  // ── Aggregates ─────────────────────────────────────────────────────────

  @override
  Future<double> totalSpentForMonth(DateTime month) async {
    final txns = await getByDateRange(
      DateTime(month.year, month.month, 1),
      DateTime(month.year, month.month + 1, 0, 23, 59, 59),
    );
    return txns
        .where((t) => t.type == TransactionType.debit)
        .fold<double>(0.0, (sum, t) => sum + t.amount);
  }

  @override
  Future<double> totalIncomeForMonth(DateTime month) async {
    final txns = await getByDateRange(
      DateTime(month.year, month.month, 1),
      DateTime(month.year, month.month + 1, 0, 23, 59, 59),
    );
    return txns
        .where((t) => t.type == TransactionType.credit)
        .fold<double>(0.0, (sum, t) => sum + t.amount);
  }

  @override
  Future<double> todaySpending() async {
    final now = DateTime.now();
    final txns = await getByDateRange(
      DateTime(now.year, now.month, now.day),
      DateTime(now.year, now.month, now.day, 23, 59, 59),
    );
    return txns
        .where((t) => t.type == TransactionType.debit)
        .fold<double>(0.0, (sum, t) => sum + t.amount);
  }

  @override
  Future<double> weekSpending() async {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final txns = await getByDateRange(
      DateTime(weekStart.year, weekStart.month, weekStart.day),
      now,
    );
    return txns
        .where((t) => t.type == TransactionType.debit)
        .fold<double>(0.0, (sum, t) => sum + t.amount);
  }

  @override
  Future<Map<String, double>> spendingByCategoryForMonth(
      DateTime month) async {
    final txns = await getByDateRange(
      DateTime(month.year, month.month, 1),
      DateTime(month.year, month.month + 1, 0, 23, 59, 59),
    );
    final map = <String, double>{};
    for (final t in txns.where((t) => t.type == TransactionType.debit)) {
      map.update(t.categoryId, (v) => v + t.amount, ifAbsent: () => t.amount);
    }
    return map;
  }
}
