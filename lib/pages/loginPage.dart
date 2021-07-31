import 'package:flutter/material.dart';
import 'package:notes_app/themeData/theme_data.dart';
import 'package:notes_app/widgets/customFAB.dart';

enum loginStatus {
  loggedIn,
  loggedOut,
  credential,
  registering,
}

class Login_state extends ChangeNotifier {
  loginStatus _status = loginStatus.loggedOut;
  loginStatus get status => _status;

  void letsStart() {
    _status = loginStatus.credential;
    notifyListeners();
  }

  void logOut() {
    _status = loginStatus.loggedOut;
    notifyListeners();
  }

  void login() {
    _status = loginStatus.loggedIn;
    notifyListeners();
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({this.state});

  final Login_state state;

  String _headingText() {
    if (state.status == loginStatus.loggedOut) return "Notely";
    return "Welcome";
  }

  String _subtitleText() {
    if (state.status == loginStatus.loggedOut)
      return "Capture what’s on your mind & get a reminder later at the right place or time. You can also add voice memo & other features";
    return "Enter your Phone No. to continue";
  }

  String _fABtext() {
    if (state.status == loginStatus.loggedOut) return "Let's Start";
    return "Continue";
  }

  Widget _phoneField(BuildContext context) {
    if (state.status == loginStatus.loggedOut) return Container();
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 90, top: 20),
      child: TextField(
          maxLength: 10,
          style:
              Theme.of(context).textTheme.bodyText1.copyWith(letterSpacing: 3),
          decoration: InputDecoration(
            fillColor: color_data['greyColor'],
            filled: true,
            icon: Icon(Icons.phone_android),
            border: InputBorder.none,
          )),
    );
  }

  Widget splash(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
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
              Positioned(
                  bottom: 0,
                  left: -50,
                  child: Image.asset(
                    'lib/assets/images/landing.png',
                    width: 736,
                    height: 473,
                    fit: BoxFit.cover,
                  )),
            ],
          ),
        ),
        floatingActionButton: CustomFAB(
          onPressed: () {
            (state.status == loginStatus.loggedOut)
                ? state.letsStart()
                : state.login();
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

  // Widget loginScreen(BuildContext context) {
  //   return Scaffold(
  //     resizeToAvoidBottomInset: false,
  //     backgroundColor: Colors.white,
  //     body: SafeArea(
  //       child: Stack(
  //         children: [
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               SizedBox(
  //                 height: 116,
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(left: 20, bottom: 22),
  //                 child: Text(
  //                   "Welcome",
  //                   style: Theme.of(context).textTheme.headline1,
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(left: 20, right: 50),
  //                 child: Text(
  //                   "Enter your Phone No. to continue",
  //                   style: Theme.of(context).textTheme.bodyText1,
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(left: 20, right: 90, top: 20),
  //                 child: TextField(
  //                     maxLength: 10,
  //                     style: Theme.of(context)
  //                         .textTheme
  //                         .bodyText1
  //                         .copyWith(letterSpacing: 3),
  //                     decoration: InputDecoration(
  //                       fillColor: color_data['greyColor'],
  //                       filled: true,
  //                       icon: Icon(Icons.phone_android),
  //                       border: InputBorder.none,
  //                     )),
  //               ),
  //               Container()
  //             ],
  //           ),
  //           Positioned(
  //               bottom: 0,
  //               left: -50,
  //               child: Image.asset(
  //                 'lib/assets/images/landing.png',
  //                 width: 736,
  //                 height: 473,
  //                 fit: BoxFit.cover,
  //               )),
  //         ],
  //       ),
  //     ),
  //     floatingActionButton: Padding(
  //       padding: const EdgeInsets.only(bottom: 30, right: 12),
  //       child: ElevatedButton(
  //         onPressed: () {
  //           state.letsStart();
  //         },
  //         style: ButtonStyle(
  //             elevation: MaterialStateProperty.all(21),
  //             backgroundColor:
  //                 MaterialStateProperty.all(color_data['buttonColor']),
  //             shape: MaterialStateProperty.all(RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(100)))),
  //         child: Container(
  //           width: 163,
  //           height: 52,
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             children: [
  //               Text(
  //                 "Continue",
  //                 style: Theme.of(context).textTheme.button,
  //               ),
  //               Icon(Icons.arrow_forward)
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return splash(context);
  }
}
