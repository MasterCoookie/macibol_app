import 'package:firebase_auth/firebase_auth.dart';
import 'package:macibol/models/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // change user stream
  Stream<CustomUser> get user {
    return _auth.authStateChanges().map(_customUserFromFirebaseUser);
  }

  // create custom user based on firebase user
  CustomUser _customUserFromFirebaseUser(User user) {
    return user != null ? CustomUser(uid: user.uid) : null;
  }

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return user;
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future loginWithEmailPwd(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User resultUser = result.user;

      return _customUserFromFirebaseUser(resultUser);
    } catch (err) {
      print(err);
      return null;
    }
  }


  Future registerWithEmailPwd(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User resultUser = result.user;

      return _customUserFromFirebaseUser(resultUser);
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future logOut() async {
    try {
      return await _auth.signOut();
    } catch(err) {
      print(err);
      return null;
    }
  }
}