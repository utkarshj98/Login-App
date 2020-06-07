import 'package:flutter/material.dart';
import 'package:login/home.dart';
import 'package:login/login.dart';
import 'package:login/auth.dart';
import 'package:provider/provider.dart';
import 'package:login/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: Authentic().user,
      child: MaterialApp(
        title: "Login App",
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Login();
    } else {
      return Home(user);
    }
  }
}
