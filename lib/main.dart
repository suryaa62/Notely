import 'package:flutter/material.dart';
import 'package:notes_app/core/Notifiers/loginPageNotifier.dart';
import 'package:notes_app/core/Notifiers/profilePageNotifier.dart';
import 'package:notes_app/locator.dart';
import 'package:notes_app/pages/homePage.dart';
import 'package:notes_app/pages/loginPage.dart';
import 'package:notes_app/pages/profilePage.dart';
import 'package:notes_app/themeData/theme_data.dart';
import 'package:provider/provider.dart';

import 'core/Notifiers/detailsPageNotifier.dart';

void main() {
  setup();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<LoginPageNotifier>(
          create: (context) => locator.get<LoginPageNotifier>()),
      ChangeNotifierProvider<ProfilePageNotifier>(
          create: (context) => locator.get<ProfilePageNotifier>()),
      ChangeNotifierProvider<DetailsPageNotifier>(
          create: (context) => locator.get<DetailsPageNotifier>()),
    ],
    child: MyApp(),
  ));
  // (ChangeNotifierProvider(
  //   create: (context) => locator.get<LoginPageNotifier>(),
  //   builder: (context, child) => MyApp(),
  // )
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
          return ChangeNotifierProvider(
              create: (context) => locator.get<ProfilePageNotifier>(),
              builder: (context, child) => HomePage(value.signOut));
        return LoginPage(
          state: value,
        );
      }),
    );
  }
}
