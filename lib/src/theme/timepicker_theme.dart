import 'package:flutter/material.dart';
import 'package:iktanambiental/src/theme/app_tema.dart';

Theme temaDatePicker(context, child) {
  return Theme(
    data: Theme.of(context).copyWith(
      colorScheme: const ColorScheme.light(
        primary: AppTheme.primary, // color de la cabecera
        onPrimary: Colors.white, // color del texto e icono de la cabecera
        onSurface: Colors.black, // color del cuerpo
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: AppTheme.secundary, // button text color
        ),
      ),
    ),
    child: child!,
  );
}
