import 'package:flutter/foundation.dart';
import 'package:notes_app/core/services/FAuth.dart';

enum statesLogin {
  loggedIn,
  loggedOut,
  credential,
  registering,
  code,
  codeEntered,
}

class LoginPageNotifier extends ChangeNotifier {
  statesLogin _status = statesLogin.loggedOut;
  statesLogin get status => _status;
  FAuthenticate fAuth;
  LoginPageNotifier() {
    fAuth = FAuthenticate(logOutCallback, loginCallback);
  }

  void letsStart() {
    _status = statesLogin.credential;
    notifyListeners();
  }

  void logOutCallback() {
    _status = statesLogin.loggedOut;
    notifyListeners();
  }

  void signOut() {
    fAuth.logOut();
  }

  void loginCallback() {
    _status = statesLogin.loggedIn;
    notifyListeners();
  }

  void code() {
    if (status != statesLogin.loggedIn) {
      _status = statesLogin.code;
      notifyListeners();
    }
  }

  void verifyCode(String code) async {
    fAuth.verifyCode(code);
  }

  void phoneFieldContinue(String phone_no, void Function() code) async {
    fAuth.phoneAuth(phone_no, code);
  }
}
