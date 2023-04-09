import 'package:iktanambiental/src/db/helper_db.dart';
import 'package:iktanambiental/src/models/cliente_model.dart';

class InsertarCliente {
  Future<int?> agregarCliente(Cliente cliente) async {
    final db = await DatabaseProvider.db.database;
    int id =
        await db!.insert(DatabaseProvider.clientTABLENAME, cliente.toMap());
    return id;
  }
}
