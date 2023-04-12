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
    } else {
      await coleccion.update({
        '_id': existente['_id']
      }, {
        'clienteID': registro['clienteID'],
        'cliente': registro['cliente'],
        'ciudad': registro['ciudad'],
        'trimestre': registro['trimestre'],
      }, upsert: true);
    }
  }
  await mongodb.close();
}

Future<void> sincronizarseccionIIAMongo() async {
  final db = await DatabaseProvider.db.database;
  final List<Map<String, dynamic>> registros = await db!.query('anexocinco');
  final mongodb = await Db.create(_uri);
  await mongodb.open();
  final coleccion = mongodb.collection('SeccionII');

  var recordsToInsert = [];

  if (registros.isNotEmpty) {
    for (final registro in registros) {
      if ((registro['imagen'] != '') && (registro['imagenInfrarroja'] != '')) {
        final existente =
            await coleccion.findOne({'anexoID': registro['anexoID']});

        if (existente == null) {
          File imagen1 = File(registro['imagen']);
          File imagen2 = File(registro['imagenInfrarroja']);
          final response1 = await _cloudinary.upload(
              file: imagen1.path,
              fileBytes: imagen1.readAsBytesSync(),
              folder: 'seccionII/imagenes',
              resourceType: CloudinaryResourceType.image,
              fileName: 'imagenNor${registro['anexoID']}');

          final response2 = await _cloudinary.upload(
              file: imagen2.path,
              fileBytes: imagen2.readAsBytesSync(),
              folder: 'seccionII/imagenesInfrarrojas',
              resourceType: CloudinaryResourceType.image,
              fileName: 'imagenInfra${registro['anexoID']}');

          final urlImagen1 = response1.secureUrl;
          final urlImagen2 = response2.secureUrl;

          // final Future<CloudinaryResponse> response1Future = _cloudinary.upload(
          //   file: imagen1.path,
          //   folder: 'seccionII/imagenes',
          //   resourceType: CloudinaryResourceType.image,
          //   fileName: 'imagenNor${registro['anexoID']}',
          // );

          // final Future<CloudinaryResponse> response2Future = _cloudinary.upload(
          //   file: imagen2.path,
          //   folder: 'seccionII/imagenesInfrarrojas',
          //   resourceType: CloudinaryResourceType.image,
          //   fileName: 'imagenInfra${registro['anexoID']}',
          // );

          // final List<CloudinaryResponse> responses =
          //     await Future.wait([response1Future, response2Future]);
          // final String urlImagen1 = responses[0].secureUrl!;
          // final String urlImagen2 = responses[1].secureUrl!;

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
            'horafinalizacionInspeccion':
                registro['horafinalizacionInspeccion'],
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
            'horaComprobacionReparacion':
                registro['horaComprobacionReparacion'],
            'concentracionPosteriorReparacion':
                registro['concentracionPosteriorReparacion'],
            'noReparadofaltaComponentes':
                registro['noReparadofaltaComponentes'],
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
            'clienteID': registro['clienteID'],
          });
        } else {}
      }
    }
    if (recordsToInsert.isNotEmpty) {
      List<Map<String, dynamic>> mappedRecords = recordsToInsert
          .map((record) => Map<String, dynamic>.from(record))
          .toList();
      await mongodb.collection('SeccionII').insertMany(mappedRecords);
    }
    await db.delete('anexocinco');
    await mongodb.close();
  }
}
