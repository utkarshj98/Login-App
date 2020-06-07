import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database {
  final String uid;
  Database({this.uid});
  final CollectionReference userCollection =
      Firestore.instance.collection('users');
  Future updateDatabase(String name, String contact, String email) async {
    return await userCollection
        .document(uid)
        .setData({'name': name, 'contact': contact, 'email': email});
  }
}
