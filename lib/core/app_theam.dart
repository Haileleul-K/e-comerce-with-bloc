import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // *****************
  // static colors
  // *****************
  static const Color skeletonBaseColor = Color(0xFFDEDFE0);
  static const Color appbodyColor = Color(0xFFF5F5F5);
  static Color secondaryColor = Colors.orange.shade700;
  static Color lightSecondaryColor = Color(0xFFFEC54B);
  static const Color lightOnPrimaryColor = Color(0xFFB1B1B1);
  static const Color textColorPrimary = Colors.black;
  static const Color categoryIconColor = Color(0xFF7A1E76);
  static const Color favouriteIconColor = Color(0xFFFF0000);

  // *****************
  // Text Style - light
  // *****************
  static TextStyle lightHeadingText({required double fsize}) => TextStyle(
      color: textColorPrimary, fontSize: fsize, fontWeight: FontWeight.w600);

  static TextStyle lightBodyText(bool bold, {required double fsize}) =>
      TextStyle(
          color: textColorPrimary,
          fontWeight: bold ? FontWeight.bold : null,
          fontSize: fsize);

  // static final ThemeData lightTheme = ThemeData(
  //     scaffoldBackgroundColor: _lightPrimaryColor,
  //     appBarTheme: const AppBarTheme(
  //       iconTheme: IconThemeData(color: _iconColor),
  //       elevation: 0.3
  //     ),
  //     bottomAppBarColor: _appbarColorLight,
  //     colorScheme: const ColorScheme.light(
  //       primary: _lightPrimaryColor,
  //       onPrimary: _lightOnPrimaryColor,
  //       primaryContainer: _lightPrimaryVariantColor,
  //     ),
  //     textTheme: _lightTextTheme
  // );
}
