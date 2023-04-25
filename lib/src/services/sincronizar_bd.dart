import 'dart:io';
import 'package:cloudinary/cloudinary.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iktanambiental/src/db/helper_db.dart';
import 'package:mongo_dart/mongo_dart.dart';

Cloudinary _cloudinary = Cloudinary.signedConfig(
  apiKey: dotenv.env['API_KEY']!,
  apiSecret: dotenv.env['API_S']!,
  cloudName: dotenv.env['CLOUD']!,
);

String _uri = dotenv.env['URI']!;

Future<void> sincronizarClienteAMongo() async {
  final db = await DatabaseProvider.db.database;
  final List<Map<String, dynamic>> registros = await db!.query('cliente');
  final mongodb = await Db.create(_uri);
  await mongodb.open();
  var coleccion = mongodb.collection('Clientes');

  for (var registro in registros) {
    var existente = await coleccion.findOne({
      'clienteID': registro['clienteID'],
      'cliente': registro['cliente'],
      'ciudad': registro['ciudad'],
      'trimestre': registro['trimestre'],
    });

    if (existente == null) {
      await coleccion.insert({
        'clienteID': registro['clienteID'],
        'cliente': registro['cliente'],
        'ciudad': registro['ciudad'],
        'trimestre': registro['trimestre'],
      });
    }
    //else {
    //   await coleccion.update({
    //     '_id': existente['_id']
    //   }, {
    //     'clienteID': registro['clienteID'],
    //     'cliente': registro['cliente'],
    //     'ciudad': registro['ciudad'],
    //     'trimestre': registro['trimestre'],
    //   }, upsert: true);
    // }
  }
  await mongodb.close();
}

Future<void> sincronizarseccionIIAMongo() async {
  final db = await DatabaseProvider.db.database;
  final List<Map<String, dynamic>> registros =
      await db!.query('anexocinco', where: 'subidoNube = 0');

  final mongodb = await Db.create(_uri);
  await mongodb.open();
  final coleccion = mongodb.collection('SeccionII');
  var recordsToInsert = [];

  if (registros.isNotEmpty) {
    for (final registro in registros) {
      final existente =
          await coleccion.findOne({'anexoID': registro['anexoID']});

      if (existente == null) {
        File imagen1 = File(registro['imagen']);
        File imagen2 = File(registro['imagenInfrarroja']);

        // List<File> imagenes = [imagen1, imagen2];
        // List<String> carpeta = [
        //   'seccionII/imagenes',
        //   'seccionII/imagenesInfrarrojas'
        // ];
        // List<String> nombresImagenes = [
        //   'imagenNor${registro['anexoID']}',
        //   'imagenInfra${registro['anexoID']}'
        // ];

        // final List<String> urls = await _subirImagenes(
        //     imagenes, carpeta, nombresImagenes, CloudinaryResourceType.image);

        final urls = await subirImagenesParalelo([imagen1, imagen2], registro);

        final urlImagen1 = urls[0];
        final urlImagen2 = urls[1];

        recordsToInsert.add({
          'anexoID': registro['anexoID'],
          'nombreInstalacion': registro['nombreInstalacion'],
          'idComponente': registro['idComponente'],
          'ubicacionInstalacion': registro['ubicacionInstalacion'],
          'equipoCritico': registro['equipoCritico'],
          'inspeccionTecnicaRiesgo': registro['inspeccionTecnicaRiesgo'],
          'nombrePersonal': registro['nombrePersonal'],
          'fechaInicioInspeccion': registro['fechaInicioInspeccion'],
          'horaInicioInspeccion': registro['horaInicioInspeccion'],
          'fechafinalizacionInspeccion':
              registro['fechafinalizacionInspeccion'],
          'horafinalizacionInspeccion': registro['horafinalizacionInspeccion'],
          'velocidadViento': registro['velocidadViento'],
          'temperatura': registro['temperatura'],
          'instrumentoUtilizado': registro['instrumentoUtilizado'],
          'fechaCalibracion': registro['fechaCalibracion'],
          'desviacionProcedimiento': registro['desviacionProcedimiento'],
          'justificacionDesviacion': registro['justificacionDesviacion'],
          'interferenciaDeteccion': registro['interferenciaDeteccion'],
          'concentracionPrevia': registro['concentracionPrevia'],
          'reparado': registro['reparado'],
          'fechaReparacion': registro['fechaReparacion'],
          'horaReparacion': registro['horaReparacion'],
          'fechaComprobacionReparacion':
              registro['fechaComprobacionReparacion'],
          'horaComprobacionReparacion': registro['horaComprobacionReparacion'],
          'concentracionPosteriorReparacion':
              registro['concentracionPosteriorReparacion'],
          'noReparadofaltaComponentes': registro['noReparadofaltaComponentes'],
          'fechaRemisionComponente': registro['fechaRemisionComponente'],
          'fechaReparacionComponente': registro['fechaReparacionComponente'],
          'fechaRemplazoEquipo': registro['fechaRemplazoEquipo'],
          'volumenMetano': registro['volumenMetano'],
          'fuga': registro['fuga'],
          'observacionPersonal': registro['observacionPersonal'],
          'observacion': registro['observacion'],
          'imagen': urlImagen1,
          'imagenInfrarroja': urlImagen2,
          'anexoURL': registro['anexoURL'],
          'informeURL': registro['informeURL'],
          'trimestre': registro['trimestre'],
          'fechaRegistro': registro['fechaRegistro'],
          'subidoNube': 1,
          'clienteID': registro['clienteID'],
        });

        // final response1 = await _cloudinary.upload(
        //     file: imagen1.path,
        //     fileBytes: imagen1.readAsBytesSync(),
        //     folder: 'seccionII/imagenes',
        //     resourceType: CloudinaryResourceType.image,
        //     fileName: 'imagenNor${registro['anexoID']}');

        // final response2 = await _cloudinary.upload(
        //     file: imagen2.path,
        //     fileBytes: imagen2.readAsBytesSync(),
        //     folder: 'seccionII/imagenesInfrarrojas',
        //     resourceType: CloudinaryResourceType.image,
        //     fileName: 'imagenInfra${registro['anexoID']}');

        // final urlImagen1 = response1.secureUrl;
        // final urlImagen2 = response2.secureUrl;
      }
    }
  }

  if (recordsToInsert.isNotEmpty) {
    List<Map<String, dynamic>> mappedRecords = recordsToInsert
        .map((record) => Map<String, dynamic>.from(record))
        .toList();
    await mongodb.collection('SeccionII').insertMany(mappedRecords);
    await db.update(
      'anexocinco',
      {'subidoNube': 1},
      where: 'subidoNube = 0',
    );
    recordsToInsert.clear();
  }
  //await db.delete('anexocinco');
  await mongodb.close();
}

Future<List<String>> subirImagenesParalelo(
    List<File> imagenes, registro) async {
  final futures = imagenes.asMap().entries.map((entry) async {
    final index = entry.key;
    final imagen = entry.value;
    final carpeta =
        index == 0 ? 'seccionII/imagenes' : 'seccionII/imagenesInfrarrojas';
    final nombreImagen = index == 0
        ? 'imagenNor${registro['anexoID']}'
        : 'imagenInfra${registro['anexoID']}';
    final result = await _cloudinary.upload(
      file: imagen.path,
      fileBytes: imagen.readAsBytesSync(),
      folder: carpeta,
      resourceType: CloudinaryResourceType.image,
      fileName: nombreImagen,
    );
    return result.secureUrl!;
  });
  return Future.wait(futures.toList().cast<Future<String>>());
}
