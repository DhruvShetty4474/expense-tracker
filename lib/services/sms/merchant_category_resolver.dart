import 'package:drift/drift.dart' hide Column;
import '../../core/database/app_database.dart';
import '../../shared/models/transaction.dart';
import 'merchant_detector.dart';

/// Resolves category for a merchant using saved mappings, past transactions,
/// then built-in defaults.
class MerchantCategoryResolver {
  final AppDatabase _db;

  MerchantCategoryResolver(this._db);

  static String normalizeKey(String merchant) =>
      merchant.toLowerCase().trim().replaceAll(RegExp(r'\s+'), ' ');

  /// Returns category id if a match exists, else null.
  Future<String?> resolveCategory(String? merchant) async {
    if (merchant == null || merchant.trim().isEmpty) return null;
    final key = normalizeKey(merchant);

    final mapping = await (_db.select(_db.merchantMappingsTable)
          ..where((m) => m.merchantKey.equals(key)))
        .getSingleOrNull();
    if (mapping != null) return mapping.categoryId;

    final pastCategory = await _categoryFromPastTransactions(key);
    if (pastCategory != null) return pastCategory;

    final userMaps = await _loadUserMappings();
    return MerchantDetector(userMappings: userMaps).categoryFor(merchant);
  }

  Future<String?> _categoryFromPastTransactions(String key) async {
    final rows = await (_db.select(_db.transactionsTable)
          ..where((t) => t.merchant.isNotNull())
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)]))
        .get();

    for (final row in rows) {
      final m = row.merchant;
      if (m == null) continue;
      if (_merchantsMatch(key, normalizeKey(m))) {
        return row.categoryId;
      }
    }
    return null;
  }

  bool _merchantsMatch(String a, String b) {
    if (a == b) return true;
    if (a.contains(b) || b.contains(a)) return true;
    final aTokens = a.split(' ').where((t) => t.length > 2);
    final bTokens = b.split(' ').where((t) => t.length > 2);
    for (final t in aTokens) {
      if (bTokens.contains(t)) return true;
    }
    return false;
  }

  Future<Map<String, String>> _loadUserMappings() async {
    final rows = await _db.select(_db.merchantMappingsTable).get();
    return {for (final r in rows) r.merchantKey: r.categoryId};
  }

  /// Persists user choice so future SMS / entries auto-categorize.
  Future<void> saveMapping(String merchant, String categoryId) async {
    final key = normalizeKey(merchant);
    if (key.isEmpty) return;

    await _db.into(_db.merchantMappingsTable).insertOnConflictUpdate(
          MerchantMappingsTableCompanion.insert(
            merchantKey: key,
            categoryId: categoryId,
            userDefined: const Value(true),
          ),
        );
  }

  /// Learns from an edited transaction (merchant + category).
  Future<void> learnFromTransaction(Transaction txn) async {
    if (txn.merchant == null || txn.merchant!.trim().isEmpty) return;
    if (txn.categoryId == 'cat_other') return;
    await saveMapping(txn.merchant!, txn.categoryId);
  }
}
