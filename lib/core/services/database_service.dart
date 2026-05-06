import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // Reference to the main users collection
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  // Save or update user data
  Future<void> saveUserData(String role, String email, Map<String, dynamic> additionalData) async {
    if (uid == null) return;
    
    // Combine role and email with specific data
    Map<String, dynamic> data = {
      'role': role,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
      ...additionalData,
    };

    return await userCollection.doc(uid).set(data, SetOptions(merge: true));
  }

  // Get user data
  Future<DocumentSnapshot> getUserData() async {
    if (uid == null) throw Exception("UID is null");
    return await userCollection.doc(uid).get();
  }

  // Update specific fields
  Future<void> updateUserData(Map<String, dynamic> data) async {
    if (uid == null) return;
    return await userCollection.doc(uid).update(data);
  }
}
