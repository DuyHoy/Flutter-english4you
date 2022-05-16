import 'package:firebase_auth/firebase_auth.dart';
import 'package:sample2/authmodule/models/myuser.dart';
import 'package:sample2/authmodule/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj
  MyUser _userFromFirebaseUser(User? user) {
    print('check ne : $user');
    return MyUser(uid: user?.uid);
  }

  // create user brew obj
  MyUser _createBrews(User? user) {
    print('check ne : $user');
    return MyUser(uid: user?.uid);
  }

  // auth change user stream
  Stream<MyUser> get user {
    return FirebaseAuth.instance
        .authStateChanges()
        // .map((user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
      MyUser myUser = _userFromFirebaseUser(userCredential.user);
      print('myUser:  $myUser');
      return myUser;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebaseUser(userCredential.user);
    } catch (e) {
      print('loi ne');
      print(e.toString());
      return null;
    }
  }

  // register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      // create a new document for the user with the uid
      String uid = userCredential.user!.uid;
      await DatabaseService(uid: uid)
          .updateUserData('0', 'new crew member', 100);
      return _userFromFirebaseUser(userCredential.user);
    } catch (e) {
      print('loi ne');
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('loi rui');
      print(e.toString());
      return null;
    }
  }
}
