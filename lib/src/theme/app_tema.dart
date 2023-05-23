import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color.fromARGB(255, 1, 86, 4);
  static const Color secundary = Colors.white;

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    useMaterial3: true,
    primaryColor: primary,
    highlightColor: Colors.green,
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: primary,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white)),
    textSelectionTheme:
        const TextSelectionThemeData(selectionHandleColor: Colors.transparent),
  );
}
