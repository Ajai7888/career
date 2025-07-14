import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save role (student or mentor)
  Future<void> saveUserRole(String email, String role) async {
    await _db.collection('users').doc(email).set({'role': role});
  }

  // Get user role from Firestore
  Future<String?> getUserRole(String email) async {
    final doc = await _db.collection('users').doc(email).get();
    if (doc.exists) {
      return doc['role'];
    }
    return null;
  }
}
