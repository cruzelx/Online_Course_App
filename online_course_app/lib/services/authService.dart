import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<FirebaseUser> signIn() async {
    GoogleSignInAccount _googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await _googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: gSA.idToken, accessToken: gSA.accessToken);
    final AuthResult _authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = _authResult.user;
    print(user.metadata.lastSignInTime);
    return user;
  }

  Future<bool> checkLogin() async {
    var user = await _auth.currentUser();
    return user != null;
  }

  signOut() async {
    _googleSignIn.signOut();
  }
}
