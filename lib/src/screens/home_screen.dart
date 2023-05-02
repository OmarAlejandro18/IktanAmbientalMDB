// ignore_for_file: use_build_context_synchronously
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iktanambiental/src/db/obtener_datos.dart';
import 'package:iktanambiental/src/screens/screens.dart';
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
  @override
  void initState() {
    super.initState();
    _getDatosCliente();
  }

  _getDatosCliente() async {
    List<Map<String, dynamic>> datos = await getDataFromTable('cliente');
    setState(() {
      _datos = datos;
    });
  }

  hayDatosInspeccion() async {
    List<Map<String, dynamic>> datosIns =
        await getDataFromTable('anexocinco', where: 'subidoNube = 0');
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
          child: Text('Datos Instalación - Inspección'),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.cloud),
            splashColor: Colors.transparent,
            onPressed: () async {
              var connectivityResult = await Connectivity().checkConnectivity();
              if (connectivityResult == ConnectivityResult.none) {
                alertaNoInternet(context);
              } else {
                if (await hayDatosInspeccion()) {
                  alertaNube(context);
                  await sincronizarClienteAMongo();
                  await sincronizarseccionIIAMongo();
                  Navigator.of(context).pop();
                  _showSnackBar();
                } else {
                  alertaNoDatos(context);
                }
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
                  Icon(
                    Icons.warning_amber_rounded,
                    size: 100,
                    color: AppTheme.primary,
                  ),
                  Text('Aquí aparecerán los clientes registrados',
                      style: TextStyle(fontSize: 16)),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _datos.length,
              itemBuilder: (BuildContext context, int i) {
                final cliente = _datos[i];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InspeccionesClienteScreen(
                            clienteId: cliente['clienteID']),
                      ),
                    );
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, right: 10, left: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25)),
                      child: Card(
                        elevation: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                'Cliente N°${i + 1}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                                ' Nombre del Cliente: ${_datos[i]['cliente']}'),
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

alertaNoInternet(BuildContext context) async {
  Platform.isIOS
      ? showCupertinoDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: const Icon(
                Icons.wifi_off,
                color: Colors.red,
                size: 70,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Ups!, No hay conexión a Internet',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
        )
      : showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Icon(
                Icons.wifi_off,
                color: Colors.red,
                size: 70,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Ups!, No hay conexión a Internet',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
        );
  await Future.delayed(const Duration(seconds: 1));
  Navigator.of(context).pop();
}

alertaNube(BuildContext context) {
  Platform.isIOS
      ? showCupertinoDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
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
        )
      : showDialog(
          context: context,
          barrierDismissible: false,
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
}

alertaNoDatos(BuildContext context) async {
  Platform.isIOS
      ? showCupertinoDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: const Icon(
                Icons.warning_amber_rounded,
                color: Colors.red,
                size: 70,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'No hay información para subir',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
        )
      : showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Icon(
                Icons.warning_amber_rounded,
                color: Colors.red,
                size: 70,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  SizedBox(height: 10),
                  Text(
                    'No hay información para subir',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          },
        );
  await Future.delayed(const Duration(seconds: 1));
  Navigator.of(context).pop();
}
