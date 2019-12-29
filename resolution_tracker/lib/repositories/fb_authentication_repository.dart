

/// Repository to handle the authentication process with Firebase.
/// 
/// The singleton pattern is achieved with the classic method with a 
/// factory constructor.
class FirebaseAuthenticationRepository {

  static final FirebaseAuthenticationRepository _instance = FirebaseAuthenticationRepository._();

  factory FirebaseAuthenticationRepository() {
    return _instance;
  }

  FirebaseAuthenticationRepository._();


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