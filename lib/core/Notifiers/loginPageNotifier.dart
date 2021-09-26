import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:notes_app/core/models/userModel.dart';
import 'package:notes_app/core/services/FAuth.dart';
import 'package:notes_app/core/services/Fstore.dart';
import 'package:notes_app/locator.dart';

enum statesLogin {
  loggedIn,
  loggedOut,
  credential,
  registering,
  code,
  codeEntered,
  addData,
}

class LoginPageNotifier extends ChangeNotifier {
  statesLogin _status = statesLogin.loggedOut;
  statesLogin get status => _status;
  bool busy;
  FAuthenticate fAuth;
  LoginPageNotifier() {
    busy = false;
    fAuth = locator.get<FAuthenticate>();
    init();
  }

  void init() async {
    isBusy(true);
    await fAuth.init(logOutCallback, loginCallback);
    isBusy(false);
  }

  void letsStart() {
    _status = statesLogin.credential;
    notifyListeners();
  }

  void logOutCallback() {
    _status = statesLogin.loggedOut;
    notifyListeners();
  }

  void signOut() async {
    isBusy(true);
    await fAuth.logOut();
    isBusy(false);
  }

  void loginCallback() {
    _status = statesLogin.loggedIn;
    notifyListeners();
  }

  void code() {
    if (status != statesLogin.loggedIn) {
      _status = statesLogin.code;
      isBusy(false);
    }
  }

  void verifyCode(String code) async {
    isBusy(true);
    if (!kIsWeb) {
      await fAuth.verifyCode(code);
    } else if (kIsWeb) {
      await fAuth.verifyCodeWeb(code);
    }
    isBusy(false);
  }

  void phoneFieldContinue(String phone_no, void Function() code) async {
    isBusy(true);
    if (!kIsWeb) {
      await fAuth.phoneAuth(phone_no, code);
    } else if (kIsWeb) {
      await fAuth.phoneAuthWeb(phone_no);

      code();
    }
    // isBusy(false);
  }

  void isBusy(bool b) {
    if (busy != b) {
      busy = b;
      print(b);
      notifyListeners();
    }
  }
}
