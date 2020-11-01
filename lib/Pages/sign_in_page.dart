import 'package:flutter/material.dart';
import 'package:locker_app/Paint/CustomPaintHome.dart';
import 'package:locker_app/Widget/sign_in_button.dart';
import 'package:locker_app/CommonWidgets/custom_raised_button.dart';
import 'package:locker_app/services/auth.dart';

class SignInPage extends StatelessWidget {
  SignInPage({@required this.auth, @required this.onSignIn});
  final Function(User) onSignIn;
  final AuthBase auth;

  Future<void> _signInAnonymously() async {
    try {
      User user = await auth.signInAnonymously();
      onSignIn(user);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      User user = await auth.signInWithGoogle();
      onSignIn(user);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent() {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          TopBar_home(),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Quickstand'),
                  ),
                ),
                SizedBox(height: 90.0),
                SignInButton(
                  text: 'Sign In with Email',
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: () {},
                ),
                SizedBox(height: 16.0),
                SignInButton(
                  text: 'Sign In with Google',
                  textColor: Colors.white,
                  color: Colors.indigo,
                  onPressed: _signInWithGoogle,
                ),
                SizedBox(height: 16.0),
                SignInButton(
                  text: 'Sign In with Facebook',
                  textColor: Colors.white,
                  color: Color(0xFF334D92),
                  onPressed: () {},
                ),
                SizedBox(height: 16.0),
                SignInButton(
                  text: 'Sign In Annonymously',
                  textColor: Colors.white,
                  color: Colors.red,
                  onPressed: _signInAnonymously,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
