import 'package:flutter/material.dart';
import 'package:locker_app/Pages/home.dart';
import 'package:locker_app/Pages/sign_in_page.dart';
import 'package:locker_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LandingPage extends StatefulWidget {
  LandingPage({@required this.auth});
  final AuthBase auth;
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  FirebaseUser _user;

  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  Future<void> _checkCurrentUser() async {
    FirebaseUser user = await widget.auth.currentUser();
    _updateUser(user);
  }

  void _updateUser(FirebaseUser user) {
    setState(() {
      _user = user;
    });
    if(user!=null)
    print('${user.uid}');
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return SignInPage(
        auth: widget.auth,
        onSignIn: _updateUser,
      );
    }
    else {

      return MyHomePage(
        auth: widget.auth,

      ); //temporary to be replaced by homepage
    }
  }
}