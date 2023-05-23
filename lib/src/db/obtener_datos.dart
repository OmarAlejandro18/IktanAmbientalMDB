import 'package:iktanambiental/src/db/helper_db.dart';

Future<List<Map<String, dynamic>>> getDataFromTable(String tableName,
    {String? where}) async {
  final db = await DatabaseProvider.db.database;
  List<Map<String, dynamic>> data;
  if (where != null) {
    data = await db!.query(tableName, where: where);
  } else {
    data = await db!.query(tableName);
  }
  return data;
}
