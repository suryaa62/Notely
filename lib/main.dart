import 'package:flutter/material.dart';
import 'package:notes_app/core/Notifiers/loginPageNotifier.dart';
import 'package:notes_app/pages/homePage.dart';
import 'package:notes_app/pages/loginPage.dart';
import 'package:notes_app/themeData/theme_data.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => LoginPageNotifier(),
    builder: (context, child) => MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: myTheme(),
      home: Consumer<LoginPageNotifier>(builder: (context, value, child) {
        if (value.status == statesLogin.loggedIn)
          return HomePage(value.signOut);
        return LoginPage(
          state: value,
        );
      }),
    );
  }
}
