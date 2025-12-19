// lib/data/services/firestore_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eux_client/features/auth/data/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  // Collection reference
  CollectionReference get _usersCollection => _firestore.collection('users');

  // Create user in Firestore
  Future<void> createUser(UserModel user) async {
    try {
      await _usersCollection.doc(user.uid).set(user.toFirestore());
    } catch (e) {
      throw Exception('Failed to create user in Firestore: $e');
    }
  }

  // Get user from Firestore
  Future<UserModel?> getUser(String uid) async {
    try {
      final doc = await _usersCollection.doc(uid).get();
      if (!doc.exists) return null;
      return UserModel.fromDocument(doc);
    } catch (e) {
      throw Exception('Failed to get user from Firestore: $e');
    }
  }

  // Update user name
  Future<void> updateUserName(String uid, String name) async {
    try {
      await _usersCollection.doc(uid).update({'name': name});
    } catch (e) {
      throw Exception('Failed to update user name: $e');
    }
  }

  // Update user phones
  Future<void> updateUserPhones(String uid, List<String> phones) async {
    try {
      await _usersCollection.doc(uid).update({'phones': phones});
    } catch (e) {
      throw Exception('Failed to update user phones: $e');
    }
  }

  // Add phone to user
  Future<void> addPhone(String uid, String phone) async {
    try {
      await _usersCollection.doc(uid).update({
        'phones': FieldValue.arrayUnion([phone]),
      });
    } catch (e) {
      throw Exception('Failed to add phone: $e');
    }
  }

  // Remove phone from user
  Future<void> removePhone(String uid, String phone) async {
    try {
      await _usersCollection.doc(uid).update({
        'phones': FieldValue.arrayRemove([phone]),
      });
    } catch (e) {
      throw Exception('Failed to remove phone: $e');
    }
  }

  // Delete user
  Future<void> deleteUser(String uid) async {
    try {
      await _usersCollection.doc(uid).delete();
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }

  // Check if user exists
  Future<bool> userExists(String uid) async {
    try {
      final doc = await _usersCollection.doc(uid).get();
      return doc.exists;
    } catch (e) {
      throw Exception('Failed to check if user exists: $e');
    }
  }

  // Stream of user data
  Stream<UserModel?> userStream(String uid) {
    return _usersCollection.doc(uid).snapshots().map((doc) {
      if (!doc.exists) return null;
      return UserModel.fromDocument(doc);
    });
  }
}
