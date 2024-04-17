import 'package:flutter/material.dart';

// The main class for setting up a theme for the entire application.
class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Montserrat',
    disabledColor: const Color(0xfffaaaaaa),
    primaryColor: const Color(0xfff7c815),
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      labelMedium: TextStyle(
        fontSize: 13,
        color: Color(0xfffaaaaaa),
        fontWeight: FontWeight.w500,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w700,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      bodySmall: TextStyle(
        fontSize: 11,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xfff7c815)),
  );
}
