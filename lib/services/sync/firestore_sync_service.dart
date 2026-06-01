import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../core/database/app_database.dart';
import '../../shared/enums/transaction_source.dart';
import '../../shared/enums/transaction_type.dart';
import '../../shared/models/transaction.dart' as model;

/// Local-first dual storage: SQLite is source of truth; Firestore is backup.
class FirestoreSyncService {
  final AppDatabase _db;
  String? _userId;

  FirestoreSyncService(this._db);

  bool get isAvailable {
    try {
      Firebase.app();
      return _userId != null && _userId!.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  CollectionReference<Map<String, dynamic>>? get _transactions {
    if (!isAvailable) return null;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(_userId)
        .collection('transactions');
  }

  void setUserId(String? userId) => _userId = userId;

  /// Full bidirectional sync — call on app start and after connectivity restore.
  Future<SyncResult> syncAll() async {
    if (!isAvailable) {
      return const SyncResult(skipped: true, reason: 'Firebase or user not ready');
    }

    var uploaded = 0;
    var downloaded = 0;

    uploaded = await _uploadPending();
    downloaded = await _downloadMissing();

    return SyncResult(uploaded: uploaded, downloaded: downloaded);
  }

  Future<void> pushTransaction(model.Transaction txn) async {
    if (!isAvailable) return;
    await _transactions!.doc(txn.id).set(_toFirestore(txn), SetOptions(merge: true));
    await _markSynced(txn.id);
  }

  Future<void> pushDelete(String id) async {
    if (!isAvailable) return;
    await _transactions!.doc(id).delete();
  }

  Future<int> _uploadPending() async {
    final rows = await (_db.select(_db.transactionsTable)
          ..where((t) => t.synced.equals(false)))
        .get();

    var count = 0;
    for (final row in rows) {
      final txn = _fromRow(row);
      await _transactions!.doc(txn.id).set(_toFirestore(txn), SetOptions(merge: true));
      await _markSynced(txn.id);
      count++;
    }
    return count;
  }

  Future<int> _downloadMissing() async {
    final snap = await _transactions!.get();
    if (snap.docs.isEmpty) return 0;

    final localIds = await _db.select(_db.transactionsTable).get();
    final localSet = localIds.map((r) => r.id).toSet();

    var count = 0;
    for (final doc in snap.docs) {
      if (localSet.contains(doc.id)) continue;
      final txn = _fromFirestore(doc.id, doc.data());
      if (txn == null) continue;
      await _db.into(_db.transactionsTable).insertOnConflictUpdate(
            _toCompanion(txn.copyWith(synced: true)),
          );
      count++;
    }
    return count;
  }

  Future<void> _markSynced(String id) async {
    await (_db.update(_db.transactionsTable)..where((t) => t.id.equals(id)))
        .write(const TransactionsTableCompanion(synced: Value(true)));
  }

  Map<String, dynamic> _toFirestore(model.Transaction t) => {
        'amount': t.amount,
        'type': t.type.name,
        'categoryId': t.categoryId,
        'timestamp': t.timestamp.toIso8601String(),
        'source': t.source.name,
        'merchant': t.merchant,
        'note': t.note,
        'tags': t.tags,
        'refNumber': t.refNumber,
        'isRecurring': t.isRecurring,
        'recurringId': t.recurringId,
        'updatedAt': DateTime.now().toIso8601String(),
      };

  model.Transaction? _fromFirestore(String id, Map<String, dynamic> data) {
    try {
      return model.Transaction(
        id: id,
        amount: (data['amount'] as num).toDouble(),
        type: TransactionType.values.byName(data['type'] as String),
        categoryId: data['categoryId'] as String,
        timestamp: DateTime.parse(data['timestamp'] as String),
        source: TransactionSource.values.byName(
          (data['source'] as String?) ?? 'manual',
        ),
        merchant: data['merchant'] as String?,
        note: data['note'] as String?,
        tags: (data['tags'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
        refNumber: data['refNumber'] as String?,
        isRecurring: data['isRecurring'] as bool? ?? false,
        recurringId: data['recurringId'] as String?,
        synced: true,
      );
    } catch (_) {
      return null;
    }
  }

  model.Transaction _fromRow(TransactionsTableData r) => model.Transaction(
        id: r.id,
        amount: r.amount,
        type: r.type,
        categoryId: r.categoryId,
        timestamp: r.timestamp,
        source: r.source,
        merchant: r.merchant,
        note: r.note,
        tags: r.tags.isEmpty
            ? []
            : List<String>.from(jsonDecode(r.tags) as List),
        refNumber: r.refNumber,
        isRecurring: r.isRecurring,
        recurringId: r.recurringId,
        synced: r.synced,
      );

  TransactionsTableCompanion _toCompanion(model.Transaction t) =>
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
}

class SyncResult {
  final bool skipped;
  final String? reason;
  final int uploaded;
  final int downloaded;

  const SyncResult({
    this.skipped = false,
    this.reason,
    this.uploaded = 0,
    this.downloaded = 0,
  });

  bool get ok => !skipped;
}

/// Ensures Firebase Auth session for Firestore rules (anonymous for guests).
Future<String?> ensureFirebaseUser() async {
  try {
    Firebase.app();
  } catch (_) {
    return null;
  }

  var user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    final cred = await FirebaseAuth.instance.signInAnonymously();
    user = cred.user;
  }
  return user?.uid;
}
