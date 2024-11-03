import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_ecom_app/auth/model/app_user.dart';
import 'package:riverpod_ecom_app/firebase_constants.dart';

class AuthRepo {
  Future signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        return userCredential.user;
      } else {
        return Future.error('Failed to login');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        await addUserToFirestore(email: email, uid: userCredential.user!.uid);

        return userCredential.user;
      } else {
        return Future.error('Failed to login');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future addUserToFirestore(
      {required String email, required String uid}) async {
    FirebaseFirestore.instance
        .collection(FirebaseConstants.usersCollection)
        .doc(uid)
        .set(AppUser(
                id: uid,
                email: email,
                name: 'Test User',
                photoUrl: null,
                isDeleted: false)
            .toMap());
  }

  Future signOut() {
    return FirebaseAuth.instance.signOut();
  }
}

final authRepoProvider = Provider((ref) => AuthRepo());
