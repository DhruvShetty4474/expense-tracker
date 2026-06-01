import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:firebase_core/firebase_core.dart';

import '../../core/database/app_database.dart';

/// Cloud retention policy (local DB is never pruned — stays fast on-device).
///
/// When calendar year advances (e.g. into 2026), delete **cloud copies**
/// of transactions from **July–December of the previous year** (H2).
/// Local SQLite keeps full history.
class DataRetentionService {
  final AppDatabase _db;

  DataRetentionService(this._db);

  /// Run on app startup. Safe to call every launch — no-ops if not due.
  Future<void> runYearlyCloudRetentionIfNeeded({String? userId}) async {
    if (userId == null || userId.isEmpty || userId == 'guest') return;

    try {
      Firebase.app();
    } catch (_) {
      return; // Firebase not configured
    }

    final now = DateTime.now();
    if (now.month != 1) return; // only evaluate each January

    final prevYear = now.year - 1;
    final rangeStart = DateTime(prevYear, 7, 1);
    final rangeEnd = DateTime(prevYear, 12, 31, 23, 59, 59);

    final alreadyRan = await _ranForYear(now.year);
    if (alreadyRan) return;

    await _purgeCloudRange(userId, rangeStart, rangeEnd);
    await _markRanForYear(now.year);
  }

  Future<bool> _ranForYear(int year) async {
    final marker = await (_db.select(_db.aiInsightsTable)
          ..where((t) => t.type.equals('retention_$year')))
        .getSingleOrNull();
    return marker != null;
  }

  Future<void> _markRanForYear(int year) async {
    await _db.into(_db.aiInsightsTable).insertOnConflictUpdate(
          AiInsightsTableCompanion.insert(
            id: 'retention_marker_$year',
            type: 'retention_$year',
            content: 'Cloud H2 ${year - 1} purge completed',
            generatedAt: DateTime.now(),
            dismissed: const Value(true),
          ),
        );
  }

  Future<void> _purgeCloudRange(
    String userId,
    DateTime start,
    DateTime end,
  ) async {
    final firestore = FirebaseFirestore.instance;
    final coll = firestore
        .collection('users')
        .doc(userId)
        .collection('transactions');

    final snap = await coll
        .where('timestamp', isGreaterThanOrEqualTo: start.toIso8601String())
        .where('timestamp', isLessThanOrEqualTo: end.toIso8601String())
        .get();

    if (snap.docs.isEmpty) return;

    final batch = firestore.batch();
    for (final doc in snap.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();

    // Mark local rows as unsynced so they can re-upload if policy changes
    await (_db.update(_db.transactionsTable)
          ..where((t) =>
              t.timestamp.isBiggerOrEqualValue(start) &
              t.timestamp.isSmallerOrEqualValue(end)))
        .write(const TransactionsTableCompanion(synced: Value(false)));
  }
}
