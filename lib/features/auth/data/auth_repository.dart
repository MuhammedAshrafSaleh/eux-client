// lib/data/repositories/auth_repository.dart
import 'package:eux_client/features/auth/data/firestore_service.dart';
import 'package:eux_client/features/auth/data/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirestoreService _firestoreService;

  AuthRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
    FirestoreService? firestoreService,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
       _firestoreService = firestoreService ?? FirestoreService();

  // Get current user
  Future<UserModel?> get currentUser async {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) return null;

    // Get user from Firestore
    return await _firestoreService.getUser(firebaseUser.uid);
  }

  // Register with email and password
  Future<UserModel> registerWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      // Create Firebase Auth user
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw Exception('Registration failed');
      }

      // Create UserModel
      final user = UserModel(
        uid: userCredential.user!.uid,
        name: name,
        email: email,
        phone: phoneNumber, // Empty initially
      );

      // Save user to Firestore
      await _firestoreService.createUser(user);

      return user;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw Exception('An unexpected error occurred during registration: $e');
    }
  }

  // Login with email and password
  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw Exception('Login failed');
      }

      // Get user from Firestore
      final user = await _firestoreService.getUser(userCredential.user!.uid);

      if (user == null) {
        throw Exception('User data not found');
      }

      return user;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw Exception('An unexpected error occurred during login: $e');
    }
  }

  // Reset password
  Future<void> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw Exception('An unexpected error occurred while sending reset email');
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('An error occurred during sign out');
    }
  }

  // Check if user is logged in
  bool isUserLoggedIn() {
    return _firebaseAuth.currentUser != null;
  }

  // Update user name
  Future<void> updateName(String uid, String name) async {
    try {
      await _firestoreService.updateUserName(uid, name);
    } catch (e) {
      throw Exception('Failed to update name: $e');
    }
  }

  // Update user phones
  Future<void> updatePhones(String uid, List<String> phones) async {
    try {
      await _firestoreService.updateUserPhones(uid, phones);
    } catch (e) {
      throw Exception('Failed to update phones: $e');
    }
  }

  // Add phone
  Future<void> addPhone(String uid, String phone) async {
    try {
      await _firestoreService.addPhone(uid, phone);
    } catch (e) {
      throw Exception('Failed to add phone: $e');
    }
  }

  // Remove phone
  Future<void> removePhone(String uid, String phone) async {
    try {
      await _firestoreService.removePhone(uid, phone);
    } catch (e) {
      throw Exception('Failed to remove phone: $e');
    }
  }

  // Handle Firebase Auth exceptions
  String _handleFirebaseAuthException(firebase_auth.FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'The password provided is too weak';
      case 'email-already-in-use':
        return 'An account already exists for this email';
      case 'user-not-found':
        return 'No user found with this email';
      case 'wrong-password':
        return 'Wrong password provided';
      case 'invalid-email':
        return 'The email address is invalid';
      case 'user-disabled':
        return 'This user account has been disabled';
      case 'too-many-requests':
        return 'Too many requests. Please try again later';
      case 'operation-not-allowed':
        return 'This operation is not allowed';
      case 'network-request-failed':
        return 'Network error. Please check your connection';
      default:
        return e.message ?? 'An authentication error occurred';
    }
  }
}
