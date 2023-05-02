import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color.fromARGB(255, 1, 86, 4);
  static const Color secundary = Colors.white;

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: primary,
    highlightColor: Colors.green,
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      elevation: 0,
    ),
    textSelectionTheme:
        const TextSelectionThemeData(selectionHandleColor: Colors.transparent),
  );
}
