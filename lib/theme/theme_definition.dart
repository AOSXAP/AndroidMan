import 'package:flutter/material.dart';

/// This file stores the configuration of the themes
class AppColors {
  static Color purple = Colors.deepPurple;
}

class ThemeDefinition {
  static Color accentColor = AppColors.purple;

  static ThemeData get lightTheme {
    accentColor = AppColors.purple;
    return _lightTheme;
  }

  static ThemeData get darkTheme {
    accentColor = Colors.white;
    return _darkTheme;
  }

  static final ThemeData _lightTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.purple, brightness: Brightness.light),
      scaffoldBackgroundColor: Colors.white,
      primaryColor: AppColors.purple,
      canvasColor: Colors.white,
      cardColor: Colors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          AppColors.purple,
        ),
      )),
      textTheme: const TextTheme(
        displayMedium: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w400,
            color: Colors.deepPurple),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.all(16.0),
      ));

  static final ThemeData _darkTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.purple, brightness: Brightness.dark),
      scaffoldBackgroundColor: Colors.black38,
      primaryColor: AppColors.purple,
      canvasColor: Colors.black38,
      cardColor: Colors.black38,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          AppColors.purple,
        ),
      )),
      textTheme: const TextTheme(
        displayMedium: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w400,
            color: Colors.deepPurple),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.all(16.0),
      ));
}
