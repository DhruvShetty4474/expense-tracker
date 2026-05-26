import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';

// ── Repository provider ──────────────────────────────────────────────────

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final repo = AuthRepositoryImpl();
  ref.onDispose(repo.dispose);
  return repo;
});

// ── Auth state notifier ───────────────────────────────────────────────────

class AuthNotifier extends AsyncNotifier<AppUser?> {
  @override
  Future<AppUser?> build() async {
    final repo = ref.watch(authRepositoryProvider) as AuthRepositoryImpl;
    // Attempt to restore a previous session (guest or Firebase token)
    return repo.restoreSession();
  }

  Future<void> signInAsGuest() async {
    state = const AsyncLoading();
    final repo = ref.read(authRepositoryProvider);
    state = await AsyncValue.guard(repo.signInAsGuest);
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    final repo = ref.read(authRepositoryProvider);
    state = await AsyncValue.guard(repo.signInWithGoogle);
  }

  Future<void> signInWithEmail(String email, String password) async {
    state = const AsyncLoading();
    final repo = ref.read(authRepositoryProvider);
    state = await AsyncValue.guard(
        () => repo.signInWithEmail(email, password));
  }

  Future<void> signOut() async {
    final repo = ref.read(authRepositoryProvider);
    await repo.signOut();
    state = const AsyncData(null);
  }
}

final authProvider = AsyncNotifierProvider<AuthNotifier, AppUser?>(
  AuthNotifier.new,
);

// ── Convenience derived providers ─────────────────────────────────────────

final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).valueOrNull != null;
});

final currentUserProvider = Provider<AppUser?>((ref) {
  return ref.watch(authProvider).valueOrNull;
});
