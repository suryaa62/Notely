import 'package:flutter/material.dart';
import 'package:notes_app/pages/loginPage.dart';
import 'package:notes_app/themeData/theme_data.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => Login_state(),
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
      home: Consumer<Login_state>(
        builder: (context, value, child) => LoginPage(
          state: value,
        ),
      ),
    );
  }
}
