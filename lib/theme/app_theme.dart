import 'package:flutter/material.dart';

class AppTheme {
  static Color lightBackgroundColor = Colors.white;
  static Color lightPrimaryColor = const Color(0xfff2f2f2);
  static Color lightAccentColor = Colors.black;
  static Color lightParticlesColor = const Color(0x44948282);
  static Color lightTextColor = Colors.grey[700];


  static Color darkBackgroundColor = Colors.black;
  static Color darkPrimaryColor = const Color(0xFF1A2127);
  static Color darkAccentColor = Colors.white;
  static Color darkParticlesColor = const Color(0x441C2A3D);
  static Color darkTextColor = Colors.grey;

  const AppTheme._();

  static final lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: lightPrimaryColor,
      accentColor: lightAccentColor,
      backgroundColor: lightBackgroundColor,
    secondaryHeaderColor: lightTextColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,

      primaryIconTheme: IconThemeData(
        color: lightAccentColor,
      ),
      );

  static final darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: darkPrimaryColor,
      accentColor: darkAccentColor,
      backgroundColor: darkBackgroundColor,
      secondaryHeaderColor: darkTextColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryIconTheme: IconThemeData(
        color: darkAccentColor,
      ),
  );
}
