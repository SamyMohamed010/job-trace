import 'package:firebase_auth/firebase_auth.dart';
import 'database_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream to listen to auth state changes
  Stream<User?> get user => _auth.authStateChanges();

  // Get current user ID
  String? get currentUid => _auth.currentUser?.uid;

  // Sign up
  Future<UserCredential?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String role, // 'student' or 'company'
    required Map<String, dynamic> additionalData,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;
      if (user != null) {
        // Save additional user data to Firestore
        await DatabaseService(uid: user.uid).saveUserData(role, email, additionalData);
      }
      return result;
    } on FirebaseAuthException catch (e) {
      print('Failed to sign up: \${e.message}');
      throw e;
    }
  }

  // Sign in
  Future<UserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result;
    } on FirebaseAuthException catch (e) {
      print('Failed to sign in: \${e.message}');
      throw e;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('Failed to sign out: \$e');
      throw e;
    }
  }
}
