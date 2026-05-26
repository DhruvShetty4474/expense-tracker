import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';

// ignore: constant_identifier_names
const _kGuestUidKey = 'guest_uid';
// ignore: constant_identifier_names
const _kGuestActiveKey = 'guest_active';

/// Auth repository implementation.
/// Firebase Auth is injected optionally — falls back to guest-only mode when
/// Firebase has not been configured (no google-services.json yet).
class AuthRepositoryImpl implements AuthRepository {
  final FlutterSecureStorage _storage;
  final _controller = StreamController<AppUser?>.broadcast();
  AppUser? _current;

  AuthRepositoryImpl({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  @override
  Stream<AppUser?> get authStateChanges => _controller.stream;

  @override
  AppUser? get currentUser => _current;

  @override
  Future<AppUser> signInWithGoogle() async {
    // Firebase integration placeholder — wire up when google-services.json is added.
    // FirebaseAuth.instance.signInWithGoogle() goes here.
    throw UnimplementedError(
        'Configure Firebase (add google-services.json) to enable Google sign-in.');
  }

  @override
  Future<AppUser> signInWithEmail(String email, String password) async {
    // Firebase Auth placeholder — wire up when google-services.json is added.
    throw UnimplementedError(
        'Configure Firebase (add google-services.json) to enable email sign-in.');
  }

  @override
  Future<AppUser> signInAsGuest() async {
    var uid = await _storage.read(key: _kGuestUidKey);
    uid ??= const Uuid().v4();
    await _storage.write(key: _kGuestUidKey, value: uid);
    await _storage.write(key: _kGuestActiveKey, value: 'true');

    final user = AppUser(uid: uid, displayName: 'Guest', isGuest: true);
    _current = user;
    _controller.add(user);
    return user;
  }

  @override
  Future<void> signOut() async {
    await _storage.delete(key: _kGuestActiveKey);
    _current = null;
    _controller.add(null);
  }

  /// Restores a previous guest session on app cold start.
  Future<AppUser?> restoreSession() async {
    final isGuest = await _storage.read(key: _kGuestActiveKey);
    if (isGuest == 'true') {
      final uid = await _storage.read(key: _kGuestUidKey) ?? const Uuid().v4();
      final user = AppUser(uid: uid, displayName: 'Guest', isGuest: true);
      _current = user;
      _controller.add(user);
      return user;
    }
    return null;
  }

  void dispose() => _controller.close();
}
