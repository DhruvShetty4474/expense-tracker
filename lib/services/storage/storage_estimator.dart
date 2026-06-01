/// Estimates local DB size and Firebase free-tier headroom for transactions.
class StorageEstimate {
  final int transactionCount;
  final int estimatedLocalBytes;
  final int estimatedCloudBytes;
  final int projectedYearlyTransactions;
  final String summary;

  const StorageEstimate({
    required this.transactionCount,
    required this.estimatedLocalBytes,
    required this.estimatedCloudBytes,
    required this.projectedYearlyTransactions,
    required this.summary,
  });

  double get localMb => estimatedLocalBytes / (1024 * 1024);
  double get cloudMb => estimatedCloudBytes / (1024 * 1024);

  /// Firebase Spark (free) Firestore storage: 1 GiB ≈ 1,073,741,824 bytes
  static const firebaseFreeStorageBytes = 1073741824;

  double get firebaseUsagePercent =>
      (estimatedCloudBytes / firebaseFreeStorageBytes * 100).clamp(0, 100);

  bool get withinFirebaseFreeTier =>
      estimatedCloudBytes < firebaseFreeStorageBytes * 0.8;
}

class StorageEstimator {
  /// ~400 bytes per transaction row (typical Indian UPI/SMS ledger).
  static const bytesPerTransaction = 400;

  /// Active SMS/UPI user: ~100 tx/month average.
  static const defaultTxPerMonth = 100;

  static StorageEstimate estimate({
    required int transactionCount,
    int txPerMonth = defaultTxPerMonth,
  }) {
    final localBytes = transactionCount * bytesPerTransaction;
    final yearlyTx = txPerMonth * 12;
    final cloudBytes = transactionCount * bytesPerTransaction;

    final summary = transactionCount == 0
        ? 'No transactions yet. At ~$txPerMonth/month you\'d use ~${((yearlyTx * bytesPerTransaction) / (1024 * 1024)).toStringAsFixed(1)} MB/year locally — well within Firebase free tier.'
        : '${localMb(localBytes)} MB local · ${localMb(cloudBytes)} MB if fully synced to Firebase '
            '(${((cloudBytes / StorageEstimate.firebaseFreeStorageBytes) * 100).toStringAsFixed(2)}% of 1 GB free tier)';

    return StorageEstimate(
      transactionCount: transactionCount,
      estimatedLocalBytes: localBytes,
      estimatedCloudBytes: cloudBytes,
      projectedYearlyTransactions: yearlyTx,
      summary: summary,
    );
  }

  static String localMb(int bytes) =>
      (bytes / (1024 * 1024)).toStringAsFixed(2);
}
