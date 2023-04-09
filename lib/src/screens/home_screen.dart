import 'package:flutter/material.dart';
import 'package:iktanambiental/src/db/obtener_datos.dart';
import 'package:iktanambiental/src/screens/formulario_cliente_screen.dart';
import 'package:iktanambiental/src/services/sincronizar_bd.dart';
import 'package:iktanambiental/src/theme/app_tema.dart';

final _scaffey = GlobalKey<ScaffoldState>();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _datos = [];
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _getDatosCliente();
  }

  _getDatosCliente() async {
    List<Map<String, dynamic>> datos =
        await getDataFromTable('cliente'); // Llama al método para obtener datos
    setState(() {
      _datos = datos; // Actualiza el estado del widget con los datos obtenidos
    });
  }

  hayDatosInspeccion() async {
    List<Map<String, dynamic>> datosIns = await getDataFromTable('anexocinco');
    if (datosIns.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffey,
      appBar: AppBar(
        title: const Center(
          child: Text('Datos Instalación-Inspección'),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.cloud),
            onPressed: () async {
              if (await hayDatosInspeccion()) {
                // ignore: use_build_context_synchronously
                showDialog(
                  context: context,
                  barrierDismissible:
                      false, // Impedir cerrar el AlertDialog al hacer clic fuera de él
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Sincronizando...'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          CircularProgressIndicator(),
                          SizedBox(height: 10),
                          Text('Por favor, espera...'),
                        ],
                      ),
                    );
                  },
                );
                setState(() {
                  _isLoading = true; // Mostrar indicador de carga
                });

                // Simular espera de 2 segundos
                await Future.delayed(const Duration(seconds: 10));

                // Llamar a los métodos de sincronización
                sincronizarClienteAMongo();
                sincronizarseccionIIAMongo();

                setState(() {
                  _isLoading = false; // Ocultar indicador de carga
                });

                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
                _showSnackBar();
              }
            },
          ),
        ],
      ),
      body: _datos.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.warning, size: 48),
                  Text('Aquí aparecerán los clientes registrados',
                      style: TextStyle(fontSize: 16)),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _datos.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('Nombre: ${_datos[index]['cliente']}'),
                  subtitle:
                      Text('ciudad de cliente: ${_datos[index]['ciudad']}'),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primary,
        onPressed: () => {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ClienteScreen()),
          )
        },
        //Navigator.pushNamed(context, 'clienteScreen'),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showSnackBar() {
    SnackBar snackBar =
        const SnackBar(content: Text('Datos subidos a la Nube Exitosamente'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
