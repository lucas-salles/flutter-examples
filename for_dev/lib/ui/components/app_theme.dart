import 'package:flutter/material.dart';

ThemeData makeAppTheme() {
  const primaryColor = Color.fromRGBO(136, 14, 79, 1);
  const primaryColorDark = Color.fromRGBO(96, 0, 39, 1);
  const primaryColorLight = Color.fromRGBO(188, 71, 123, 1);
  final ThemeData theme = ThemeData();

  return theme.copyWith(
    primaryColor: primaryColor,
    primaryColorDark: primaryColorDark,
    primaryColorLight: primaryColorLight,
    colorScheme: theme.colorScheme.copyWith(
      primary: primaryColor,
      secondary: primaryColor,
      background: Colors.white,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: primaryColorDark,
      ),
      titleMedium: TextStyle(
        color: primaryColor,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      iconColor: primaryColorLight,
      labelStyle: TextStyle(color: primaryColorLight),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: primaryColorLight,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: primaryColor,
        ),
      ),
      alignLabelWithHint: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
  );
}
