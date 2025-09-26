import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:test_databse/model/profile.dart';

class UserRegisController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ฟังก์ชันอัปโหลดรูปไป Firebase Storage
  Future<String?> uploadImageToFirebase(File file, String uid) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('$uid.jpg');

      await ref.putFile(file); // อัปโหลด
      final downloadUrl = await ref.getDownloadURL();
      print("Uploaded to Firebase Storage: $downloadUrl");
      return downloadUrl;
    } catch (e) {
      print("Upload error: $e");
      return null;
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String phone,
    File? imageFile,
  }) async {
    UserCredential cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    String? photoUrl;
    if (imageFile != null) {
      photoUrl = await uploadImageToFirebase(imageFile, cred.user!.uid);

      print("Cloud URL: $photoUrl");
    }

    final profile = Profile(
      uid: cred.user!.uid,
      email: email,
      password: password,
      name: name,
      userType: UserType.user,
      photoUrl: photoUrl,
    );

    await _db.collection('users').doc(profile.uid).set({
      ...profile.toMap(),
      'phone': phone,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
