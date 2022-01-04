import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetes_app/model/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth.dart';

class FirestoreApi {
  final db = FirebaseFirestore.instance;

  Future<void> userSignUpWithEmail(
      AppUser newUser, BuildContext context) async {
    final auth = Provider.of<Auth>(context, listen: false);
    final user = await auth.createUserWithEmailAndPassword(
      newUser.email,
      newUser.password!,
    );
    if (user != null) {
      auth.currentuser!.sendEmailVerification();
      DocumentReference ref = db.doc('users/${user.uid}');
      await ref.set(newUser.toJson());
      await auth.currentuser!.updateDisplayName('AppkesathUser2021');
      auth.signOut();
    }
  }

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
}
