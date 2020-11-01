import 'package:flutter/material.dart';
import 'package:locker_app/Pages/home.dart';
import 'package:locker_app/Pages/sign_in_page.dart';
import 'package:locker_app/services/auth.dart';

class LandingPage extends StatefulWidget {
  LandingPage({@required this.auth});
  final AuthBase auth;
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User _user;

  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  Future<void> _checkCurrentUser() async {
    User user = await widget.auth.currentUser();
    _updateUser(user);
  }

  void _updateUser(User user) {
    setState(() {
      _user = user;
    });
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
    return MyHomePage(
      auth: widget.auth,
      onSignOut: () => _updateUser(null),
    ); //temporary to be replaced by homepage
  }
}
