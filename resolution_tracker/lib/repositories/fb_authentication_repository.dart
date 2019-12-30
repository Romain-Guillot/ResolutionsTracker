import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

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


  FirebaseAuthenticationRepository._() {
  }

  Stream<User> getUserStream() {
    _auth.currentUser();
    StreamTransformer<FirebaseUser, User> streamTransformer = StreamTransformer.fromHandlers(
      handleData: (fbUser, sink) => sink.add(User(fbUser))
    );
    return _auth.onAuthStateChanged.transform(streamTransformer);
  }


  signInWithGoogle() {

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