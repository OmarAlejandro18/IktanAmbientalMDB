import 'package:flutter/material.dart';
import 'package:iktanambiental/src/db/helper_db.dart';
import 'package:iktanambiental/src/db/obtener_datos.dart';
import 'package:iktanambiental/src/providers/providers.dart';
import 'package:iktanambiental/src/screens/screens.dart';
import 'package:iktanambiental/src/theme/app_tema.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  eliminarRegistrosSubidos30dias();
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
        ChangeNotifierProvider(create: (context) => NoReparadoProvider()),
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
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('es', ''),
        ],
        theme: AppTheme.lightTheme,
      ),
    );
  }
}

void eliminarRegistrosSubidos30dias() async {
  final db = await DatabaseProvider.db.database;
  List<Map<String, dynamic>> datosIns = await getDataFromTable('anexocinco');
  if (datosIns.isNotEmpty) {
    final now = DateTime.now().millisecondsSinceEpoch;
    final thirtyDaysAgo = now - (30 * 24 * 60 * 60 * 1000); //
    await db!.delete(
      'anexocinco',
      where: 'fechaRegistro >= ? AND subidoNube = 1',
      whereArgs: [thirtyDaysAgo],
    );
  } else {
    print('no hay datos que eliminar');
  }
}
