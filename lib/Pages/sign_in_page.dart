import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locker_app/Pages/home.dart';
import 'package:locker_app/Pages/email_login_page.dart';
import 'package:locker_app/Paint/CustomPaintHome.dart';
import 'package:locker_app/Widget/sign_in_button.dart';
import 'package:locker_app/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locker_app/helper/users_data.dart';

///Certificate fingerprints:
// 	 MD5:  D5:C2:BC:8C:6F:5B:72:2D:7C:61:76:C2:A2:5A:AA:25
// 	 SHA1: E2:EF:E6:0B:9A:CD:B3:C8:48:49:51:9A:F5:F7:B3:40:BA:B6:45:E0
// 	 SHA256: D1:7C:ED:0B:22:DC:6C:2F:AB:E0:DC:37:FC:62:01:63:23:92:90:FA:F1:C1:D5:2C:EE:D4:3D:55:1A:0B:8D:3B

class SignInPage extends StatelessWidget {
  SignInPage({@required this.auth, @required this.onSignIn});
  final Function(FirebaseUser) onSignIn;
  final AuthBase auth;
  bool newUser=false;


  Future<void> _signInAnonymously() async {
    try {
      FirebaseUser  user= await auth.signInAnonymously();
      onSignIn(user);
    } catch (e) {
      print(e.toString() + "Ananaohhhhh");
    }
  }

  Future <bool > isNewUser(FirebaseUser user) async {


      QuerySnapshot result = await Firestore.instance
          .collection("User")
          .where("email", isEqualTo: user.email)
          .getDocuments();
      final List<DocumentSnapshot> docs = result.documents;
       return docs.length == 0 ? true : false;


  }

  addUserToDb(FirebaseUser currentuser) async {
      if(newUser) {
        Users _user = await Users(
            currentuser.uid, currentuser.email, currentuser.photoUrl,
            currentuser.displayName,currentuser.phoneNumber,currentuser.providerId);
        print("Adding new User to Db");

     await   Firestore.instance.collection("User")
            .document(currentuser.uid)
            .setData(_user.toJson());
      }
      else
        print("User ALredy Exists");

  }




  Future<void> _signInWithGoogle() async {
    try {
      FirebaseUser user = await auth.signInWithGoogle();
      onSignIn(user);

        newUser=await isNewUser(user);
        addUserToDb(user);
    } catch (e) {
      print(e.toString() + " Vishal Google");
    }
  }
  Future<void> _signInWithFacebook() async {
    try {
      FirebaseUser user = await auth.signInWithFacebook();
      onSignIn(user);

      newUser=await isNewUser(user);
      addUserToDb(user);
    } catch (e) {
      print(e.toString() + " Vishal Google");
    }
  }






  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Scaffold(
      body: Stack(

        children: <Widget>[
          TopBar_home(),
          Padding(
            padding: EdgeInsets.all(16.0),
            child:

            Column(
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
                  onPressed:() {

                    Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => LoginPage(auth: auth)
                        )
                    );
                  },
                ),
                SizedBox(height: 16.0),
                SignInButton(
                  text: 'Sign In with Google',
                  textColor: Colors.white,
                  color: Colors.indigo,
                  onPressed: _signInWithGoogle

                ),
                SizedBox(height: 16.0),
                SignInButton(
                  text: 'Sign In with Facebook',
                  textColor: Colors.white,
                  color: Color(0xFF334D92),
                  onPressed: _signInWithFacebook,
                ),
                SizedBox(height: 16.0),
                SignInButton(
                  text: 'Sign In Annonymously',
                  textColor: Colors.white,
                  color: Colors.red,
                  onPressed: (){},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
