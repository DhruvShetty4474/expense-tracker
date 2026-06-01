import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';

// ignore: constant_identifier_names
const _kGuestUidKey = 'guest_uid';
// ignore: constant_identifier_names
const _kGuestActiveKey = 'guest_active';

class AuthRepositoryImpl implements AuthRepository {
  final FlutterSecureStorage _storage;
  final GoogleSignIn _googleSignIn;
  final _controller = StreamController<AppUser?>.broadcast();
  AppUser? _current;

  AuthRepositoryImpl({
    FlutterSecureStorage? storage,
    GoogleSignIn? googleSignIn,
  })  : _storage = storage ?? const FlutterSecureStorage(),
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  @override
  Stream<AppUser?> get authStateChanges => _controller.stream;

  @override
  AppUser? get currentUser => _current;

  bool get _firebaseReady {
    try {
      Firebase.app();
      return true;
    } catch (_) {
      return false;
    }
  }

  FirebaseAuth get _auth => FirebaseAuth.instance;

  AppUser _mapUser(User user, {bool forceGuest = false}) {
    final isGuest = forceGuest || user.isAnonymous;
    return AppUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName ??
          (isGuest ? 'Guest' : user.email?.split('@').first),
      photoUrl: user.photoURL,
      isGuest: isGuest,
    );
  }

  Future<void> _persistSession(AppUser user) async {
    await _storage.write(key: _kGuestUidKey, value: user.uid);
    await _storage.write(
      key: _kGuestActiveKey,
      value: user.isGuest ? 'true' : 'false',
    );
    _current = user;
    _controller.add(user);
  }

  String _authErrorMessage(Object e) {
    if (e is FirebaseAuthException) {
      return switch (e.code) {
        'user-not-found' => 'No account found for this email.',
        'wrong-password' => 'Incorrect password.',
        'email-already-in-use' => 'An account already exists with this email.',
        'invalid-email' => 'Invalid email address.',
        'weak-password' => 'Password is too weak (min 6 characters).',
        'network-request-failed' => 'Network error — check your connection.',
        _ => e.message ?? 'Authentication failed.',
      };
    }
    if (e is StateError) return e.message;
    return e.toString();
  }

  Future<T> _guardAuth<T>(Future<T> Function() fn) async {
    try {
      return await fn();
    } catch (e) {
      throw StateError(_authErrorMessage(e));
    }
  }

  @override
  Future<AppUser> signInWithGoogle() => _guardAuth(() async {
    if (!_firebaseReady) {
      throw StateError('Firebase is not configured on this device.');
    }

    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      throw StateError('Google sign-in was cancelled.');
    }

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final result = await _auth.signInWithCredential(credential);
    final user = result.user;
    if (user == null) throw StateError('Google sign-in failed.');

    final appUser = _mapUser(user);
    await _persistSession(appUser);
    return appUser;
  });

  @override
  Future<AppUser> signInWithEmail(String email, String password) =>
      _guardAuth(() async {
    if (!_firebaseReady) {
      throw StateError('Firebase is not configured on this device.');
    }
    if (email.isEmpty || password.length < 6) {
      throw StateError('Enter a valid email and password (min 6 characters).');
    }

    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = result.user;
    if (user == null) throw StateError('Email sign-in failed.');

    final appUser = _mapUser(user);
    await _persistSession(appUser);
    return appUser;
  });

  @override
  Future<AppUser> signUpWithEmail(String email, String password) =>
      _guardAuth(() async {
    if (!_firebaseReady) {
      throw StateError('Firebase is not configured on this device.');
    }
    if (email.isEmpty || password.length < 6) {
      throw StateError('Enter a valid email and password (min 6 characters).');
    }

    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = result.user;
    if (user == null) throw StateError('Account creation failed.');

    final appUser = _mapUser(user);
    await _persistSession(appUser);
    return appUser;
  });

  Future<String> _firebaseOrLocalUid() async {
    if (_firebaseReady) {
      var fbUser = _auth.currentUser;
      fbUser ??= (await _auth.signInAnonymously()).user;
      if (fbUser != null) return fbUser.uid;
    }
    var uid = await _storage.read(key: _kGuestUidKey);
    return uid ?? const Uuid().v4();
  }

  @override
  Future<AppUser> signInAsGuest() async {
    if (_firebaseReady) {
      final cred = await _auth.signInAnonymously();
      final user = cred.user;
      if (user != null) {
        final appUser = _mapUser(user, forceGuest: true);
        await _persistSession(appUser);
        return appUser;
      }
    }

    final uid = await _firebaseOrLocalUid();
    final user = AppUser(uid: uid, displayName: 'Guest', isGuest: true);
    await _persistSession(user);
    return user;
  }

  @override
  Future<void> signOut() async {
    await _storage.delete(key: _kGuestActiveKey);
    try {
      if (_firebaseReady) {
        await _googleSignIn.signOut();
        await _auth.signOut();
      }
    } catch (_) {}
    _current = null;
    _controller.add(null);
  }

  /// Restores Firebase or guest session on cold start.
  Future<AppUser?> restoreSession() async {
    if (_firebaseReady) {
      final fbUser = _auth.currentUser;
      if (fbUser != null) {
        final isGuest = fbUser.isAnonymous ||
            (await _storage.read(key: _kGuestActiveKey)) == 'true';
        final user = _mapUser(fbUser, forceGuest: isGuest);
        _current = user;
        _controller.add(user);
        return user;
      }
    }

    final isGuest = await _storage.read(key: _kGuestActiveKey);
    if (isGuest == 'true') {
      return signInAsGuest();
    }
    return null;
  }

  void dispose() => _controller.close();
}
