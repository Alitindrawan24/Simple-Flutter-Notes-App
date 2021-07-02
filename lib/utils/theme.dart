import 'package:flutter/material.dart';

class Themes {
  static ThemeData light = ThemeData(
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: Colors.orange,
    ),
    fontFamily: 'Montserrat',
    brightness: Brightness.light,
    primarySwatch: Colors.orange,
    textTheme: const TextTheme(
      headline4: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat',
          color: Colors.white),
      headline5: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat',
          color: Colors.black),
      headline6: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat',
          color: Colors.black),
      bodyText1: TextStyle(
          fontSize: 13.0, fontFamily: 'Montserrat', color: Colors.black),
      bodyText2: TextStyle(
          fontSize: 10.0, fontFamily: 'Montserrat', color: Colors.black),
    ),
  );
}
