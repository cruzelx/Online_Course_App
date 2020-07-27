import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:online_course_app/locator.dart';
import 'package:online_course_app/models/userModel.dart';
import 'package:online_course_app/services/userService.dart';

class AuthenticationService {
  UserService _userService = locator<UserService>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<FirebaseUser> get user => _auth.onAuthStateChanged;

  User _currentUser;
  User get currentUser => _currentUser;

  Future<FirebaseUser> signIn() async {
    GoogleSignInAccount _googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await _googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: gSA.idToken, accessToken: gSA.accessToken);
    final AuthResult _authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = _authResult.user;
    print(user);

    _userService.fetchUser(user.email).then((value) {
      if (value != null) {
        _currentUser = value;
      } else {
        User newUser = User(
            id: user.email,
            username: user.displayName,
            email: user.email,
            dp: user.photoUrl);

        _userService.createUser(newUser).then((value) => _currentUser = value);
      }
    });
    return user;
  }

  Future<bool> checkLogin() async {
    var user = await _auth.currentUser();
    return user != null;
  }

  signOut() async {
    _googleSignIn.signOut();
    _currentUser = null;
  }
}
