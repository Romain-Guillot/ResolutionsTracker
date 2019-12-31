
import 'package:flutter/widgets.dart';
import 'package:resolution_tracker/repositories/fb_authentication_repository.dart';
import 'package:resolution_tracker/models/models.dart';


class AuthenticationNotifier extends ChangeNotifier {

  FirebaseAuthenticationRepository _authRepo = FirebaseAuthenticationRepository();
  bool isInit = false;
  User user;

  AuthenticationNotifier() {
    _initUserSnapshot();
  }

  _initUserSnapshot() {
    _authRepo.getUserStream().listen(
      (u) {
        isInit = true;
        user = u;
        notifyListeners();
      }, 
      onDone: () {isInit = true; notifyListeners();},
      onError: (_) {isInit = true; notifyListeners();}
    );
  }
}