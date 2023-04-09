import 'package:iktanambiental/src/db/helper_db.dart';

Future<List<Map<String, dynamic>>> getDataFromTable(String tableName) async {
  final db = await DatabaseProvider.db.database;
  final List<Map<String, dynamic>> data = await db!.query(tableName);
  return data;
}
