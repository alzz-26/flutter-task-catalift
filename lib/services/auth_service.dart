import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user; //_auth.currentUser;
  bool? newUser;

  AuthService() {
    _auth.authStateChanges().listen((User? newUser) {
      user = newUser;
      notifyListeners();
    });
  }

  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }

  Future<void> signInWithEmail(String email, String password) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    user = userCredential.user;
    newUser = userCredential.additionalUserInfo?.isNewUser ?? false;
    notifyListeners();
  }

  Future<void> register(String email, String password) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    user = userCredential.user;
    newUser = true; // Since this is a new account
    print('new user created');
    if (userCredential.user?.uid == user?.uid) {
      print('new user loged in also');
    }
    else {
      print('new user only registered');
    }
  }

  Future<void> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential = await _auth.signInWithCredential(credential);
    user = userCredential.user;
    newUser = userCredential.additionalUserInfo?.isNewUser ?? false;
    notifyListeners();
  }
}
