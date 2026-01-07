import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skin/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String password, String name);
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
  Future<void> forgotPassword(String email);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl(this.firebaseAuth, this.firestore);

  @override
  Future<UserModel> login(String email, String password) async {
    final credential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (credential.user != null) {
      // Fetch user data from Firestore
      final userDoc = await firestore
          .collection('users')
          .doc(credential.user!.uid)
          .get();

      if (userDoc.exists) {
        final data = userDoc.data()!;
        return UserModel(
          id: credential.user!.uid,
          email: credential.user!.email ?? '',
          name: data['name'] as String?,
        );
      }

      return UserModel.fromFirebase(credential.user!);
    } else {
      throw Exception('Login failed: User is null');
    }
  }

  @override
  Future<UserModel> register(String email, String password, String name) async {
    final credential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credential.user != null) {
      // Update Firebase Auth display name
      await credential.user!.updateDisplayName(name);

      // Save user data to Firestore
      await firestore.collection('users').doc(credential.user!.uid).set({
        'id': credential.user!.uid,
        'email': email,
        'name': name,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return UserModel(id: credential.user!.uid, email: email, name: name);
    } else {
      throw Exception('Registration failed: User is null');
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = firebaseAuth.currentUser;
    if (user == null) return null;

    // Fetch user data from Firestore
    final userDoc = await firestore.collection('users').doc(user.uid).get();

    if (userDoc.exists) {
      final data = userDoc.data()!;
      return UserModel(
        id: user.uid,
        email: user.email ?? '',
        name: data['name'] as String?,
      );
    }

    return UserModel.fromFirebase(user);
  }

  @override
  Future<void> forgotPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
