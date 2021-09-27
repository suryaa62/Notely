import 'package:flutter/material.dart';
import 'package:notes_app/core/Notifiers/loginPageNotifier.dart';
import 'package:notes_app/themeData/theme_data.dart';
import 'package:notes_app/widgets/customFAB.dart';
import 'package:notes_app/widgets/progressIndicator.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.state});

  final LoginPageNotifier state;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _fieldController = TextEditingController();
  bool _validated = true;
  final _validationString = RegExp(r"^[6-9]\d{9}$");

  @override
  void dispose() {
    _fieldController.dispose();
    super.dispose();
  }

  String _headingText() {
    if (widget.state.status == statesLogin.loggedOut) return "Notely";
    if (widget.state.status == statesLogin.credential) return "Welcome";
    return "Enter Code";
  }

  String _subtitleText() {
    if (widget.state.status == statesLogin.loggedOut)
      return "Capture what’s on your mind & get a reminder later at the right place or time. You can also add voice memo & other features";
    if (widget.state.status == statesLogin.credential)
      return "Enter your Phone No. to continue";
    return "Please verify yourself by entering the code sent you via sms";
  }

  String _fABtext() {
    if (widget.state.status == statesLogin.loggedOut) return "Let's Start";
    if (widget.state.status == statesLogin.credential) return "Continue";
    return "Verify";
  }

  Widget _phoneField(BuildContext context) {
    if (widget.state.status == statesLogin.loggedOut) return Container();
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 90, top: 20),
      child: TextField(
          controller: _fieldController,
          maxLength: 10,
          onEditingComplete: () async {
            if (widget.state.status == statesLogin.credential) {
              if (_validationString.hasMatch(_fieldController.text) ||
                  _fieldController.text == "1234567890") {
                widget.state.phoneFieldContinue(
                    _fieldController.text, widget.state.code);
                _fieldController.text = "";
                setState(() {
                  _validated = true;
                });
              } else {
                _fieldController.text = "";
                setState(() {
                  _validated = false;
                });
              }
            } else if (widget.state.status == statesLogin.code) {
              widget.state.verifyCode(_fieldController.text);
            }
          },
          style:
              Theme.of(context).textTheme.bodyText1.copyWith(letterSpacing: 3),
          decoration: InputDecoration(
              fillColor: color_data['greyColor'],
              filled: true,
              icon: Icon(Icons.phone_android),
              border: InputBorder.none,
              errorText:
                  (_validated) ? null : "Please Enter A Valid Phone No!")),
    );
  }

  Widget splash(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Progress(
            busy: widget.state.busy,
            child: Stack(
              children: [
                Positioned(
                    bottom: 0,
                    left: -50,
                    child: Image.asset(
                      'lib/assets/images/landing.png',
                      width: 736,
                      height: 473,
                      fit: BoxFit.cover,
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 116,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, bottom: 22),
                      child: Text(
                        _headingText(),
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 50),
                      child: Text(
                        _subtitleText(),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    _phoneField(context),
                  ],
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: CustomFAB(
          onPressed: () async {
            if (widget.state.status == statesLogin.loggedOut)
              widget.state.letsStart();
            else if (widget.state.status == statesLogin.credential) {
              if (_validationString.hasMatch(_fieldController.text)) {
                widget.state.phoneFieldContinue(
                    _fieldController.text, widget.state.code);
                _fieldController.text = "";
                setState(() {
                  _validated = true;
                });
              } else {
                _fieldController.text = "";
                setState(() {
                  _validated = false;
                });
              }
            } else if (widget.state.status == statesLogin.code) {
              widget.state.verifyCode(_fieldController.text);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                _fABtext(),
                style: Theme.of(context).textTheme.button,
              ),
              Icon(Icons.arrow_forward)
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return splash(context);
  }
}
