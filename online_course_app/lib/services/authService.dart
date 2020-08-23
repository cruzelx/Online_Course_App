import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:online_course_app/locator.dart';
import 'package:online_course_app/models/userModel.dart';
import 'package:online_course_app/services/userService.dart';

class AuthenticationService {
  UserService _userService = locator<UserService>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User> get onAuthStateChange =>
      _auth.onAuthStateChanged.map(_convertUser);

  User _convertUser(FirebaseUser user) {
    if (user == null) return null;
    return User(
        id: user.email,
        username: user.displayName,
        email: user.email,
        dp: user.photoUrl,
        isAdmin: false);
  }

signIn() async {
    try {
      GoogleSignInAccount _googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication gSA =
          await _googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: gSA.idToken, accessToken: gSA.accessToken);
      final AuthResult _authResult =
          await _auth.signInWithCredential(credential);
      final FirebaseUser user = _authResult.user;
      var userFromDB = await _userService.fetchUser(user.email);

      if (userFromDB != null) {
        print(userFromDB);
        return userFromDB;
      }
      User userToStore = _convertUser(user);
      userToStore.createdAt = Timestamp.now();

      await _userService.createUserWithCustomId(userToStore);
     
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
