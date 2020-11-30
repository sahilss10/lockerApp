import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';



abstract class AuthBase {
  Future<FirebaseUser> currentUser();
  Future<FirebaseUser> signInAnonymously();
  Future<void> signOut();
  Future<FirebaseUser> signInWithGoogle();
  Future<FirebaseUser> signInWithFacebook();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser current;



  @override
  Future< FirebaseUser> currentUser() async {
    final user = await _firebaseAuth.currentUser();
    return user;

  }
  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<FirebaseUser> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return authResult.user;
  }

  @override
  Future<FirebaseUser> signInWithGoogle() async {
    GoogleSignInAccount googleSignInAccount;
   if(googleSignInAccount==null)
     {
    try {
      googleSignInAccount = await _handleGoogleSignIn();
      final googleAuth = await googleSignInAccount.authentication;
      final googleAuthCred = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      final User = await _firebaseAuth.signInWithCredential(googleAuthCred);
      print("User : " + User.additionalUserInfo.profile.toString());
      return User.user;

    } catch (error) {
      throw PlatformException(
        code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
        message: 'Missing Google Auth token',
      );
    }
     }
   else {
     throw PlatformException(
       code: 'ERROR_ABORTED_BY_USER',
       message: 'Sign in aborted by user',
     );
   }
  }

  @override
  Future<FirebaseUser> signInWithFacebook() async {
    FacebookLoginResult facebookLoginResult;
    if(facebookLoginResult==null)
    {
      try {

        facebookLoginResult = await _handleFBSignIn();
        final accessToken = facebookLoginResult.accessToken.token;
        if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
          final facebookAuthCred = FacebookAuthProvider.getCredential(accessToken: accessToken);
          final user = await _firebaseAuth.signInWithCredential(facebookAuthCred);
          print("User : " + user.toString());
          return user.user;
      } }
        catch (error) {
        throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing Google Auth token',
        );
      }
    }
    else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }



  Future<FacebookLoginResult> _handleFBSignIn() async {
    FacebookLogin facebookLogin = FacebookLogin();
    FacebookLoginResult facebookLoginResult =
    await facebookLogin.logInWithReadPermissions(['email','public_profile']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.cancelledByUser:
        print("Cancelled");
        break;
      case FacebookLoginStatus.error:
        print("error");
        break;
      case FacebookLoginStatus.loggedIn:
        print("Logged In");
        break;
    }
    return facebookLoginResult;
  }





  Future<GoogleSignInAccount> _handleGoogleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email']);
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    return googleSignInAccount;
  }




}
