import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/di/providers.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../storage/data_retention_service.dart';
import 'firestore_sync_service.dart';

final firestoreSyncServiceProvider = Provider<FirestoreSyncService>((ref) {
  return FirestoreSyncService(ref.watch(databaseProvider));
});

final syncStatusProvider =
    AsyncNotifierProvider<SyncStatusNotifier, SyncResult?>(SyncStatusNotifier.new);

class SyncStatusNotifier extends AsyncNotifier<SyncResult?> {
  @override
  Future<SyncResult?> build() => Future.value(null);

  Future<SyncResult> runSync() async {
    state = const AsyncLoading();
    final sync = ref.read(firestoreSyncServiceProvider);

    final firebaseUid = await ensureFirebaseUser();
    final appUser = ref.read(currentUserProvider);
    final userId = firebaseUid ?? appUser?.uid;

    if (userId != null) {
      sync.setUserId(userId);
      await DataRetentionService(ref.read(databaseProvider))
          .runYearlyCloudRetentionIfNeeded(userId: userId);
    }

    final result = await sync.syncAll();
    state = AsyncData(result);
    return result;
  }

  Future<void> pushAfterChange() async {
    final sync = ref.read(firestoreSyncServiceProvider);
    if (!sync.isAvailable) {
      final firebaseUid = await ensureFirebaseUser();
      if (firebaseUid != null) sync.setUserId(firebaseUid);
    }
    if (sync.isAvailable) {
      await sync.syncAll();
    }
  }
}
