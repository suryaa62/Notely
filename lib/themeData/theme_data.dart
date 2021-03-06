import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

ThemeData myTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFF6273ED),
    primaryColorDark: Color(0xff1f48ba),
    primaryColorLight: Color(0xff99a1ff),
    accentColor: Color(0xFF6273ED),
    scaffoldBackgroundColor: Color(0xFFFBFCFF),
    cardColor: Color(0xffffffff),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: color_data["buttonColor"],
      elevation: 21,
    ),
    fontFamily: 'Metropolis',
    textTheme: TextTheme(
        headline1: TextStyle(
            color: Colors.black,
            fontFamily: 'Metropolis',
            fontWeight: FontWeight.w900,
            fontSize: 35),
        headline2: TextStyle(
            color: Colors.black,
            fontFamily: 'Metropolis',
            fontWeight: FontWeight.w700,
            fontSize: 23),
        bodyText1: TextStyle(
            fontFamily: 'Metropolis',
            fontSize: 16,
            height: 1.3,
            color: Color(0xFF535353)),
        bodyText2: TextStyle(
            fontFamily: 'Metropolis', fontSize: 16, color: Color(0xFF535353)),
        button: TextStyle(
            fontFamily: 'Metropolis',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white),
        subtitle1: TextStyle(
            fontFamily: 'Metropolis',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black),
        subtitle2: TextStyle(
            fontFamily: 'Metropolis',
            fontSize: 12,
            fontWeight: FontWeight.w300,
            color: Colors.black)),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: color_data['greyColor'],
      filled: true,
      border: InputBorder.none,
    ),
  );
}

ThemeData myDarkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xFF6273ED),
    primaryColorDark: Color(0xff1f48ba),
    primaryColorLight: Color(0xff99a1ff),
    accentColor: Color(0xFF6273ED),
    scaffoldBackgroundColor: Color(0xFF242C39),
    cardColor: Color(0xff37465D),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: color_data["buttonColor"],
      elevation: 21,
    ),
    fontFamily: 'Metropolis',
    textTheme: TextTheme(
        headline1: TextStyle(
            color: Colors.white,
            fontFamily: 'Metropolis',
            fontWeight: FontWeight.w900,
            fontSize: 35),
        headline2: TextStyle(
            color: Colors.white,
            fontFamily: 'Metropolis',
            fontWeight: FontWeight.w700,
            fontSize: 23),
        bodyText1: TextStyle(
            fontFamily: 'Metropolis',
            fontSize: 16,
            height: 1.3,
            color: Colors.white54),
        bodyText2: TextStyle(
            fontFamily: 'Metropolis', fontSize: 16, color: Color(0xFF535353)),
        button: TextStyle(
            fontFamily: 'Metropolis',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white),
        subtitle1: TextStyle(
            fontFamily: 'Metropolis',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white),
        subtitle2: TextStyle(
            fontFamily: 'Metropolis',
            fontSize: 12,
            fontWeight: FontWeight.w300,
            color: Colors.white)),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Color(0xff56657D),
      filled: true,
      border: InputBorder.none,
    ),
  );
}

class ThemeNotifier extends ChangeNotifier {
  ThemeData currentTheme = myTheme();

  ThemeData giveTheme(String s) {
    if (s == 'dark') currentTheme = myDarkTheme();
    if (s == 'light') currentTheme = myTheme();
    notifyListeners();
  }
}

var color_data = {
  "buttonColor": Color(0xFF6273ED),
  "audioColor": Color(0xffFC6B6B),
  "reminderColor": Color(0xff4DC992),
  "imageColor": Color(0xff4DC992),
  "checklistColor": Color(0xffFFA726),
  "greyColor": Color(0xffF1F1F1),
};

String formateDate(DateTime date) =>
    new DateFormat("dd MMM yyyy,").add_jm().format(date);
