
import 'package:flutter/widgets.dart';
import 'package:resolution_tracker/repositories/fb_authentication_repository.dart';
import 'package:resolution_tracker/models/models.dart';


class AuthenticationNotifier extends ChangeNotifier {

  FirebaseAuthenticationRepository _authRepo = FirebaseAuthenticationRepository();
  User user;

  AuthenticationNotifier() {
    _initUserSnapshot();
  }

  _initUserSnapshot() {
    _authRepo.getUserStream().listen(
      (u) {
        user = u;
        notifyListeners();
      }, 
      onDone: () => notifyListeners(),
      onError: (_) => notifyListeners());
  }



}