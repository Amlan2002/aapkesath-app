import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetes_app/model/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth.dart';

class FirestoreApi {
  final db = FirebaseFirestore.instance;

  Future<void> userSignUpWithThirdparyProvider(
      AppUser newUser, BuildContext context) async {
    final auth = Provider.of<Auth>(context, listen: false);
    final user = auth.currentuser;
    if (user != null) {
      DocumentReference ref = db.doc('users/${user.uid}');
      await ref.set(newUser.toJson());
      await auth.currentuser!.updateDisplayName('AppkesathUser2021');
    }
  }

  Stream<AppUser?> getCurrentUserDetailsStream(String userId) {
    DocumentReference ref = db.doc('users/$userId');
    final snapshot = ref.snapshots();
    return snapshot.map((snapshot) => AppUser.fromJson(snapshot.data()));
  }
}
