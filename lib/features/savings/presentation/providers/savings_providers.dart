import 'package:drift/drift.dart' hide Column;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../app/di/providers.dart';
import '../../../../core/database/app_database.dart';
import '../../../../shared/models/savings_goal.dart';

final savingsGoalsProvider = StreamProvider<List<SavingsGoal>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.savingsGoalsTable).watch().map((rows) => rows
      .map((r) => SavingsGoal(
            id: r.id,
            name: r.name,
            target: r.target,
            current: r.current,
            deadline: r.deadline,
            color: r.color,
          ))
      .toList());
});

class SavingsNotifier extends Notifier<void> {
  @override
  void build() {}

  Future<void> add({
    required String name,
    required double target,
    DateTime? deadline,
    String color = '#7C4DFF',
  }) async {
    final db = ref.read(databaseProvider);
    await db.into(db.savingsGoalsTable).insert(
          SavingsGoalsTableCompanion(
            id: Value(const Uuid().v4()),
            name: Value(name),
            target: Value(target),
            current: const Value(0),
            deadline: Value(deadline),
            color: Value(color),
          ),
        );
  }

  Future<void> addFunds(String id, double amount) async {
    final db = ref.read(databaseProvider);
    final rows =
        await (db.select(db.savingsGoalsTable)..where((t) => t.id.equals(id)))
            .get();
    if (rows.isEmpty) return;
    final current = rows.first.current + amount;
    await (db.update(db.savingsGoalsTable)..where((t) => t.id.equals(id)))
        .write(SavingsGoalsTableCompanion(current: Value(current)));
  }

  Future<void> delete(String id) async {
    final db = ref.read(databaseProvider);
    await (db.delete(db.savingsGoalsTable)..where((t) => t.id.equals(id))).go();
  }
}

final savingsNotifierProvider =
    NotifierProvider<SavingsNotifier, void>(SavingsNotifier.new);
