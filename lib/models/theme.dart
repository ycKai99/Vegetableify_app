import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get darktheme {
    return ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        accentColor: Colors.green[100],
        focusColor: Colors.greenAccent,
        textSelectionTheme: TextSelectionThemeData(
            selectionHandleColor: Colors.greenAccent,
            cursorColor: Colors.greenAccent),
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 42.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 24.0, fontStyle: FontStyle.italic),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.greenAccent,
        ));
  }

  static ThemeData get lighttheme {
    return ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.green[100],
        accentColor: Colors.green[100],
        focusColor: Colors.greenAccent,
        textSelectionTheme: TextSelectionThemeData(
            selectionHandleColor: Colors.greenAccent,
            cursorColor: Colors.greenAccent),
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.greenAccent,
        ));
  }
}
