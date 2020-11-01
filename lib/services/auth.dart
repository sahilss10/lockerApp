import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class User {
  User({@required this.uid});
  final String uid;
}

abstract class AuthBase {
  Future<User> currentUser();
  Future<User> signInAnonymously();
  Future<void> signOut();
  Future<User> signInWithGoogle();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(uid: user.uid);
  }

  @override
  Future<User> currentUser() async {
    final user = await _firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }

  @override
  Future<User> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final authResult = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.getCredential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );
        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing Google Auth token',
        );
      }
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
