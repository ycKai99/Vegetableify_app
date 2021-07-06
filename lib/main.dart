import 'package:flutter/material.dart';
import 'package:midtermstiw2044myshop/screens/splash_screen.dart';

import 'models/theme.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme.lighttheme,
      home: SplashScreen(),
    );
  }
}
