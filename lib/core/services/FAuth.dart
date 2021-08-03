import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:notes_app/core/services/Fstore.dart';
import 'package:notes_app/locator.dart';

class FAuthenticate {
  String _verificationId;
  Fstore db;
  String _phoneNo;
  ConfirmationResult _result;

  Future<void> init(void Function() noUser, void Function() hasUser) async {
    await Firebase.initializeApp();
    db = locator.get<Fstore>();

    FirebaseAuth.instance.userChanges().listen((user) async {
      print("UserChanges");
      if (user == null)
        noUser();
      else {
        print(_phoneNo);
        await db.createUser(user.uid, _phoneNo);
        hasUser();
      }
    });
  }

  Future<void> phoneAuth(
      String phone_no, void Function() verifyCodeCallback) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91" + phone_no,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          // print("+1" + phone_no);
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
    _phoneNo = phone_no;
  }

  Future<void> verifyCode(String code) async {
    String smsCode = code;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: smsCode);
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> phoneAuthWeb(String phone_no) async {
    try {
      _result =
          await FirebaseAuth.instance.signInWithPhoneNumber("+91" + phone_no);
      _phoneNo = phone_no;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> verifyCodeWeb(String code) async {
    UserCredential userCredential = await _result.confirm(code);
  }
}
