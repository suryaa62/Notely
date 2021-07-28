import 'package:flutter/material.dart';
import 'package:notes_app/themeData/theme_data.dart';

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

  void login() {
    _status = loginStatus.loggedIn;
    notifyListeners();
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({this.state});

  Login_state state;

  Widget splash(BuildContext context) {
    return Scaffold(
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
                    "Notely",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 50),
                  child: Text(
                    "Capture what’s on your mind & get a reminder later at the right place or time. You can also add voice memo & other features",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30, right: 12),
        child: ElevatedButton(
          onPressed: () {
            state.letsStart();
          },
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(21),
              backgroundColor:
                  MaterialStateProperty.all(color_data['buttonColor']),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)))),
          child: Container(
            width: 163,
            height: 52,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Let's Start",
                  style: Theme.of(context).textTheme.button,
                ),
                Icon(Icons.arrow_forward)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginScreen(BuildContext context) {
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
                    "Welcome",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 50),
                  child: Text(
                    "Enter your Phone No. to continue",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 90, top: 20),
                  child: TextField(
                      maxLength: 10,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(letterSpacing: 3),
                      decoration: InputDecoration(
                        fillColor: color_data['greyColor'],
                        filled: true,
                        icon: Icon(Icons.phone_android),
                        border: InputBorder.none,
                      )),
                ),
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30, right: 12),
        child: ElevatedButton(
          onPressed: () {
            state.letsStart();
          },
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(21),
              backgroundColor:
                  MaterialStateProperty.all(color_data['buttonColor']),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)))),
          child: Container(
            width: 163,
            height: 52,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Continue",
                  style: Theme.of(context).textTheme.button,
                ),
                Icon(Icons.arrow_forward)
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (state.status) {
      case loginStatus.loggedOut:
        {
          return splash(context);
        }
      case loginStatus.credential:
        {
          return loginScreen(context);
        }
    }
  }
}
