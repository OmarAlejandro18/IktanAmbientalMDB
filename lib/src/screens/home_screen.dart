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
  // ignore: unused_field
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
              itemBuilder: (BuildContext context, int i) {
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 10, right: 20, bottom: 10, left: 20),
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Card(
                      elevation: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Center(
                            child: Text(
                              'Cliente N°${i + 1}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(' Nombre del Cliente: ${_datos[i]['cliente']}'),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(' Ciudad del Cliente: ${_datos[i]['ciudad']}'),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
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
