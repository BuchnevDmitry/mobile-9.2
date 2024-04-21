import 'package:flutter/material.dart';

// The main class for setting up a theme for the entire application.
class AppTheme {
  AppTheme._();

  static const Color _primaryColor = Color(0xfff7c815);

  // ignore: use_full_hex_values_for_flutter_colors
  static const Color _secondaryColor = Color(0xfffaaaaaa);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Montserrat',
    disabledColor: _secondaryColor,
    primaryColor: _primaryColor,
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 22,
        color: Colors.black,
        fontWeight: FontWeight.w700,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        color: _secondaryColor,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        color: _primaryColor,
        fontWeight: FontWeight.w500,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: _primaryColor),
  );
}
