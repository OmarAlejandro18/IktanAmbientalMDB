import 'package:flutter/material.dart';
import 'package:iktanambiental/src/providers/providers.dart';
import 'package:iktanambiental/src/screens/screens.dart';
import 'package:iktanambiental/src/theme/app_tema.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FugaProvider()),
        ChangeNotifierProvider(create: (context) => ReparadoProvider()),
        ChangeNotifierProvider(create: (context) => ClienteProvider()),
        ChangeNotifierProvider(create: (context) => BotonClienteProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Iktan Ambiental',
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomeScreen(),
          'inicio': (_) => const HomeScreen(),
          'clienteScreen': (_) => const ClienteScreen(),
        },
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('es', ''), // Configurar el idioma deseado aquí
        ],
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
