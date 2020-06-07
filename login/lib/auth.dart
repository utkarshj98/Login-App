import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/main.dart';
import 'package:login/user.dart';

class Authentic {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future sign_in(String email, String password) async {
    FirebaseUser user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    return user;
  }

  Future sign_up(String email, String password) async {
    FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    return user;
  }

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
