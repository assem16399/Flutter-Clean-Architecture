import 'package:flutter/material.dart';

import 'colors.dart';

abstract class ThemeManager {
  static final appTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: kPrimaryColor,
      centerTitle: true,
    ),
    brightness: Brightness.light,
    primaryColor: kPrimaryColor,
    colorScheme: const ColorScheme.light(
      primary: kPrimaryColor,
    ),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: kPrimaryColor),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: kPrimaryColor,
      foregroundColor: kSecondaryColor,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelStyle: TextStyle(color: kPrimaryColor),
      iconColor: kSecondaryColor,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kSecondaryColor),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: kPrimaryColor),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
  );
}
