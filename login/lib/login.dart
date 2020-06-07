import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/auth.dart';
import 'package:login/database.dart';
import 'package:login/home.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Details();
  }
}

class Details extends State<Login> with SingleTickerProviderStateMixin {
  String name, email, contact, password;
  FirebaseUser user;
  bool ob = false;
  void toggle(bool value) {
    setState(() {
      ob = value;
    });
  }

  final Authentic _auth = Authentic();
  final _formkey = GlobalKey<FormState>();
  TabController _tabController;
  ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formkey,
            child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    title: Text(
                      "SignUp / Login",
                    ),
                    pinned: true,
                    floating: true,
                    forceElevated: boxIsScrolled,
                    backgroundColor: Colors.black,
                    bottom: TabBar(
                      tabs: <Widget>[
                        Tab(text: 'Register'),
                        Tab(text: 'Sign In')
                      ],
                      controller: _tabController,
                    ),
                  )
                ];
              },
              body: TabBarView(
                children: <Widget>[
                  Container(
                    color: Colors.black87,
                    child: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  cursorColor: Colors.blue,
                                  validator: (input) {
                                    if (input.isEmpty) {
                                      return "Please type a valid name";
                                    }
                                    ;
                                  },
                                  onSaved: (input) => name = input,
                                  decoration: InputDecoration(
                                    labelText: "Name",
                                    labelStyle: TextStyle(color: Colors.white),
                                  ),
                                )),
                            SizedBox(height: 20),
                            Container(
                                margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  cursorColor: Colors.blue,
                                  validator: (input) {
                                    if (input.isEmpty) {
                                      return "Please type a valid contact id";
                                    }
                                    ;
                                  },
                                  onSaved: (input) => contact = input,
                                  decoration: InputDecoration(
                                    labelText: "Contact",
                                    labelStyle: TextStyle(color: Colors.white),
                                  ),
                                )),
                            SizedBox(height: 20),
                            Container(
                                margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  cursorColor: Colors.blue,
                                  validator: (input) {
                                    if (input.isEmpty) {
                                      return "Please type a valid email id";
                                    }
                                    ;
                                  },
                                  onSaved: (input) => email = input,
                                  decoration: InputDecoration(
                                    labelText: "Email",
                                    labelStyle: TextStyle(color: Colors.white),
                                  ),
                                )),
                            SizedBox(height: 20),
                            Container(
                                margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  cursorColor: Colors.blue,
                                  validator: (input) {
                                    if (input.isEmpty || input.length < 6) {
                                      return "Please type a valid password";
                                    }
                                    ;
                                  },
                                  onSaved: (input) => password = input,
                                  decoration: InputDecoration(
                                    labelText: "Password (Min 6 Characters)",
                                    labelStyle: TextStyle(color: Colors.white),
                                  ),
                                  obscureText: !ob,
                                )),
                            Theme(
                              data:
                                  ThemeData(unselectedWidgetColor: Colors.blue),
                              child: CheckboxListTile(
                                title: Text(
                                  "Show Password",
                                  style: TextStyle(color: Colors.white),
                                ),
                                value: ob,
                                onChanged: toggle,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              ),
                            ),
                            Builder(
                                builder: (context) => FlatButton(
                                      onPressed: () => signup(context),
                                      color: Colors.lightBlue,
                                      child: Text("Sign Up",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.black87,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: TextFormField(
                                style: TextStyle(color: Colors.white),
                                cursorColor: Colors.blue,
                                validator: (input) {
                                  if (input.isEmpty) {
                                    return "Please type a valid email id";
                                  }
                                  ;
                                },
                                onSaved: (input) => email = input,
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  labelStyle: TextStyle(color: Colors.white),
                                ),
                              )),
                          SizedBox(height: 20),
                          Container(
                              margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: TextFormField(
                                style: TextStyle(color: Colors.white),
                                cursorColor: Colors.blue,
                                validator: (input) {
                                  if (input.isEmpty || input.length < 6) {
                                    return "Please type a valid password";
                                  }
                                  ;
                                },
                                onSaved: (input) => password = input,
                                decoration: InputDecoration(
                                  labelText: "Password (Min 6 Characters)",
                                  labelStyle: TextStyle(color: Colors.white),
                                ),
                                obscureText: !ob,
                              )),
                          Theme(
                            data: ThemeData(unselectedWidgetColor: Colors.blue),
                            child: CheckboxListTile(
                              title: Text(
                                "Show Password",
                                style: TextStyle(color: Colors.white),
                              ),
                              value: ob,
                              onChanged: toggle,
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                          ),
                          Builder(
                              builder: (context) => FlatButton(
                                    onPressed: () => signIn(context),
                                    color: Colors.lightBlue,
                                    child: Text("Sign In",
                                        style: TextStyle(color: Colors.white)),
                                  ))
                        ],
                      ),
                    ),
                  ),
                ],
                controller: _tabController,
              ),
            )));
  }

  Future signIn(BuildContext context) async {
    bool success = false;
    final formState = _formkey.currentState;
    if (formState.validate()) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Processing Data"),
        duration: Duration(seconds: 3),
      ));
      formState.save();
      try {
        user = await _auth.sign_in(email, password);
        success = true;
      } catch (e) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Invalid Email/Password !!"),
          duration: Duration(seconds: 3),
        ));
      }
    }
  }

  Future signup(BuildContext context) async {
    bool success = false;
    final formState = _formkey.currentState;
    if (formState.validate()) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Processing Data"),
        duration: Duration(seconds: 3),
      ));
      formState.save();
      try {
        user = await _auth.sign_up(email, password);
        await Database(uid: user.uid).updateDatabase(name, contact, email);
        success = true;
        if (success) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Account Created !!"),
            duration: Duration(seconds: 3),
          ));
        }
      } catch (e) {}
    }
  }
}
