import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class FAuthenticate {
  FAuthenticate(void Function() noUser, void Function() hasUser) {
    this.noUser = noUser;
    this.hasUser = hasUser;

    init();
  }
  void Function() noUser;
  void Function() hasUser;
  String _verificationId;

  Future<void> init() async {
    await Firebase.initializeApp();

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user == null)
        noUser();
      else
        hasUser();
    });
  }

  void phoneAuth(String phone_no, void Function() verifyCodeCallback) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+1" + phone_no,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          print("+1" + phone_no);
          print("----------------" + e.code);
        },
        codeSent: (String verificationId, int resendToken) async {
          print("-------------CodeSent--------------");
          _verificationId = verificationId;
          verifyCodeCallback();
          // String smsCode = await code();
          // PhoneAuthCredential credential = PhoneAuthProvider.credential(
          //     verificationId: verificationId, smsCode: smsCode);
          // await FirebaseAuth.instance.signInWithCredential(credential);
        },
        codeAutoRetrievalTimeout: (String verificationId) async {
          print("-------------AutoRetrival--------------");
          _verificationId = verificationId;
          verifyCodeCallback();
          // String smsCode = await code();
          // PhoneAuthCredential credential = PhoneAuthProvider.credential(
          //     verificationId: verificationId, smsCode: smsCode);
          // await FirebaseAuth.instance.signInWithCredential(credential);
        });
  }

  void verifyCode(String code) async {
    String smsCode = code;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: smsCode);
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
