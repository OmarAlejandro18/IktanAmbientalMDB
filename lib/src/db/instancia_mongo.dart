import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mongo_dart/mongo_dart.dart';

String _uri = dotenv.env['URI']!;
Db? _db;

Future<Db> getDatabase() async {
  if (_db == null) {
    final mongodb = await Db.create(_uri);
    await mongodb.open();
    _db = mongodb;
  }
  return _db!;
}
