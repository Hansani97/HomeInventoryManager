import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_inventory_manager/core/errors/auth_failure.dart';
import 'package:home_inventory_manager/data/models/user_dto.dart';
import 'package:home_inventory_manager/features/auth/domain/entities/app_user.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  })  : _auth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  String? get currentUserId => _auth.currentUser?.uid;

  Future<AppUser> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = credential.user;
      if (firebaseUser == null) {
        throw const AuthFailure('Registration failed. Please try again.');
      }

      await firebaseUser.updateDisplayName('$firstName $lastName'.trim());
      // Ensure auth token is available before Firestore security rules are evaluated.
      await firebaseUser.getIdToken(true);

      final now = DateTime.now();
      final userDto = UserDto(
        id: firebaseUser.uid,
        email: email,
        firstName: firstName,
        lastName: lastName,
        phone: phone.isEmpty ? null : phone,
        createdAt: now,
        updatedAt: now,
      );

      await _firestore
          .collection(UserDto.collectionName)
          .doc(firebaseUser.uid)
          .set(userDto.toFirestore());

      return userDto.toEntity();
    } on FirebaseAuthException catch (error) {
      throw AuthFailure(_mapAuthError(error));
    } on FirebaseException catch (error) {
      throw AuthFailure(_mapFirestoreError(error));
    }
  }

  Future<AppUser> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = credential.user;
      if (firebaseUser == null) {
        throw const AuthFailure('Sign in failed. Please try again.');
      }

      return _fetchUserProfile(firebaseUser.uid);
    } on FirebaseAuthException catch (error) {
      throw AuthFailure(_mapAuthError(error));
    } on FirebaseException catch (error) {
      throw AuthFailure(_mapFirestoreError(error));
    }
  }

  Future<AppUser?> getCurrentUser() async {
    final firebaseUser = _auth.currentUser;
    if (firebaseUser == null) return null;

    try {
      return await _fetchUserProfile(firebaseUser.uid);
    } on AuthFailure {
      return null;
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (error) {
      throw AuthFailure(_mapAuthError(error));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<AppUser> _fetchUserProfile(String userId) async {
    final doc = await _firestore.collection(UserDto.collectionName).doc(userId).get();

    if (!doc.exists) {
      throw const AuthFailure('User profile not found. Please contact support.');
    }

    return UserDto.fromFirestore(doc).toEntity();
  }

  String _mapFirestoreError(FirebaseException error) {
    if (error.code == 'permission-denied') {
      return 'Firestore access denied. Publish security rules in Firebase Console → Firestore → Rules.';
    }
    return error.message ?? 'Could not access your profile.';
  }

  String _mapAuthError(FirebaseAuthException error) {
    return switch (error.code) {
      'email-already-in-use' => 'This email is already registered.',
      'invalid-email' => 'Enter a valid email address.',
      'weak-password' => 'Password is too weak. Use at least 8 characters.',
      'user-not-found' => 'No account found for this email.',
      'wrong-password' => 'Incorrect password.',
      'invalid-credential' => 'Invalid email or password.',
      'user-disabled' => 'This account has been disabled.',
      'too-many-requests' => 'Too many attempts. Please try again later.',
      _ => error.message ?? 'Authentication failed.',
    };
  }
}
