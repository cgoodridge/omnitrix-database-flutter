import 'package:firebase_auth/firebase_auth.dart';
import 'package:sanctuary/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User currentUser;


  CustomUser _userFromFirebaseUser(User user)
  {
    return user != null ? CustomUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<CustomUser> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // Email and pass sign
  Future signInWithEmailAndPassword(String email, String password) async
  {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  // Email and pass register
  Future registerWithEmailAndPassword(String email, String password) async
  {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  // Register with email and pass

  // Sign out

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}