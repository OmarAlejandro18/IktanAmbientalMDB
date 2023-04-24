// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DatabaseProvider {
  static const String clientTABLENAME = 'cliente';
  static const String anexoTABLENAME = 'anexocinco';

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  static Future<Database> initDB() async {
    final db = await openDatabase(
      join(await getDatabasesPath(), "InstallInspect.db"),
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  static _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $clientTABLENAME (clienteID INTEGER PRIMARY KEY, cliente TEXT, ciudad TEXT, trimestre TEXT)");

    await db.execute(
        "CREATE TABLE $anexoTABLENAME (anexoID INTEGER PRIMARY KEY, nombreInstalacion TEXT, idComponente TEXT, ubicacionInstalacion TEXT, equipoCritico TEXT, inspeccionTecnicaRiesgo TEXT, nombrePersonal TEXT, fechaInicioInspeccion TEXT, horaInicioInspeccion TEXT, fechafinalizacionInspeccion TEXT, horafinalizacionInspeccion TEXT, velocidadViento TEXT, temperatura TEXT, instrumentoUtilizado TEXT, fechaCalibracion TEXT, desviacionProcedimiento TEXT, justificacionDesviacion TEXT, interferenciaDeteccion TEXT, concentracionPrevia TEXT, reparado TEXT, fechaReparacion TEXT, horaReparacion TEXT, fechaComprobacionReparacion TEXT, horaComprobacionReparacion TEXT, concentracionPosteriorReparacion TEXT, noReparadofaltaComponentes TEXT, fechaRemisionComponente TEXT, fechaReparacionComponente TEXT, fechaRemplazoEquipo TEXT, volumenMetano TEXT, fuga TEXT, observacionPersonal TEXT, observacion TEXT, imagen TEXT, imagenInfrarroja TEXT, anexoURL TEXT, informeURL TEXT, trimestre TEXT, fechaRegistro INTEGER, subidoNube INTEGER, clienteID INTEGER NOT NULL, FOREIGN KEY(clienteID) REFERENCES $clientTABLENAME(clienteID))");
  }
}
