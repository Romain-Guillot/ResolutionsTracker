import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:resolution_tracker/models/models.dart';


/// Repository to handle the authentication process with Firebase.
/// 
/// The singleton pattern is achieved with the classic method with a 
/// factory constructor.
class FirebaseAuthenticationRepository {

  static final FirebaseAuthenticationRepository _instance = FirebaseAuthenticationRepository._();

  factory FirebaseAuthenticationRepository() {
    return _instance;
  }


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleProvider = GoogleSignIn();


  FirebaseAuthenticationRepository._();


  Stream<User> getUserStream() {
    _auth.currentUser();
    StreamTransformer<FirebaseUser, User> streamTransformer = StreamTransformer.fromHandlers(
      handleData: (fbUser, sink) {
        Future.delayed(const Duration(seconds: 0), () => sink.add(fbUser == null ? null : User(fbUser)));
      }
    );
        
    return _auth.onAuthStateChanged.transform(streamTransformer);
  }


  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleProvider.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    return User(user);
  }

  signInWithEmailPassword(String email, String password) {

  }

  signUpWithEmailPassword(String email, String password) {

  }

  logout() {

  }

  delete() {

  }
}