import 'dart:io';
import 'package:cloudinary/cloudinary.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iktanambiental/src/db/helper_db.dart';
import 'package:iktanambiental/src/db/instancia_mongo.dart';
import 'package:iktanambiental/src/models/anexocinco_model.dart';

Cloudinary _cloudinary = Cloudinary.signedConfig(
  apiKey: dotenv.env['API_KEY']!,
  apiSecret: dotenv.env['API_S']!,
  cloudName: dotenv.env['CLOUD']!,
);

Future<void> sincronizarClienteAMongo() async {
  final db = await DatabaseProvider.db.database;
  final List<Map<String, dynamic>> registros = await db!.query('cliente');
  final mongodb = await getDatabase();
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
  }
}

Future<void> sincronizarseccionIIAMongo() async {
  final db = await DatabaseProvider.db.database;
  final List<Map<String, dynamic>> registros =
      await db!.query('anexocinco', where: 'subidoNube = 0');

  final mongodb = await getDatabase();
  final coleccion = mongodb.collection('SeccionII');
  List<AnexoCinco> recordsToInsert = [];
  if (registros.isNotEmpty) {
    for (final registro in registros) {
      final existente =
          await coleccion.findOne({'anexoID': registro['anexoID']});
      if (existente == null) {
        final resg = AnexoCinco.fromMap(registro);
        File imagen1 = File(resg.imagen);
        File imagen2 = File(resg.imagenInfrarroja);
        final urls = await subirImagenesParalelo([imagen1, imagen2], registro);
        final urlImg1 = urls[0];
        final urlImg2 = urls[1];
        resg.imagen = urlImg1;
        resg.imagenInfrarroja = urlImg2;
        resg.subidoNube = 1;
        recordsToInsert.add(resg);
      }
    }
  }

  if (recordsToInsert.isNotEmpty) {
    await mongodb
        .collection('SeccionII')
        .insertMany(recordsToInsert.map((resg) => resg.toMap()).toList());
    await db.update(
      'anexocinco',
      {'subidoNube': 1},
      where: 'subidoNube = 0',
    );
    recordsToInsert.clear();
  }
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
