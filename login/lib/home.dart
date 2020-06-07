import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/user.dart';

class Home extends StatefulWidget {
  Home(User user) {
    this.user = user.uid;
  }
  String user;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Authentic _auth = Authentic();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          backgroundColor: Colors.black,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signout();
                },
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                label: Text(
                  'SignOut',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: Firestore.instance
                .collection('users')
                .document(widget.user)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Text('Loading... ');
                default:
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Welcome ${snapshot.data['name']}',
                              style: TextStyle(fontSize: 25),
                            )),
                        Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Email: ${snapshot.data['email']}',
                              style: TextStyle(fontSize: 25),
                            )),
                        Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Contact: ${snapshot.data['contact']}',
                              style: TextStyle(fontSize: 25),
                            )),
                      ]);
              }
            }));
  }
}
