import 'package:flutter/material.dart';
import 'package:iktanambiental/src/db/obtener_datos.dart';

class InspeccionesClienteScreen extends StatelessWidget {
  final int clienteId;
  const InspeccionesClienteScreen({super.key, required this.clienteId});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inspecciones por cliente'),
      ),
      body: FutureBuilder(
        future: obtenerRegistrosSeccionII(clienteId),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            final registros = snapshot.data!;
            return ListView.builder(
              itemCount: registros.length,
              itemBuilder: (context, i) {
                final registro = registros[i];
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 10, right: 15, left: 15, bottom: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          offset: const Offset(-1, 2),
                        ),
                      ],
                    ),
                    child: ExpansionTile(
                      title: Text('Inspección N°${i + 1}'),
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Text(
                                'Datos de la Instalación',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            TextoInspeccion(
                                leyenda: 'Nombre de la Instalación',
                                valor: registro['nombreInstalacion']),
                            TextoInspeccion(
                                leyenda: 'ID del componente',
                                valor: registro['idComponente']),
                            TextoInspeccion(
                                leyenda: '¿Equipo Critico?',
                                valor: registro['equipoCritico']),
                            TextoInspeccion(
                                leyenda: 'Inspección Tecnica de riesgo',
                                valor: registro['inspeccionTecnicaRiesgo']),

                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            const Center(
                              child: Text(
                                'Datos de la Inspección',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            TextoInspeccion(
                                leyenda: 'Nombre del personal',
                                valor: registro['nombrePersonal']),
                            TextoInspeccion(
                                leyenda: 'Fecha de inicio de la Inspección',
                                valor: registro['fechaInicioInspeccion']),
                            TextoInspeccion(
                                leyenda: 'Hora de inicio de la Inspección',
                                valor: registro['horaInicioInspeccion']),
                            TextoInspeccion(
                                leyenda:
                                    'Fecha de finalización de la Inspección',
                                valor: registro['fechafinalizacionInspeccion']),
                            TextoInspeccion(
                                leyenda:
                                    'Hora de finalización de la Inspección',
                                valor: registro['horafinalizacionInspeccion']),
                            TextoInspeccion(
                                leyenda: 'velocidad / viento',
                                valor: registro['velocidadViento']),
                            TextoInspeccion(
                                leyenda: 'temperatura',
                                valor: registro['temperatura']),
                            TextoInspeccion(
                                leyenda: 'Instrumento utilizado',
                                valor: registro['instrumentoUtilizado']),
                            TextoInspeccion(
                                leyenda: 'Fecha de calibración',
                                valor: registro['fechaCalibracion']),
                            TextoInspeccion(
                                leyenda: 'desviación en el procedimiento',
                                valor: registro['desviacionProcedimiento']),
                            TextoInspeccion(
                                leyenda: 'Justificación de la desviación',
                                valor: registro['justificacionDesviacion']),
                            TextoInspeccion(
                                leyenda: 'Interferencias en la detección',
                                valor: registro['interferenciaDeteccion']),
                            TextoInspeccion(
                                leyenda: 'concentración Previa',
                                valor: registro['concentracionPrevia']),
                            TextoInspeccion(
                                leyenda: '¿Reparado?',
                                valor: registro['reparado']),

                            // REPARADO SI
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            const Center(
                              child: Text(
                                'Reparado Si',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            TextoInspeccion(
                                leyenda: 'Fecha de reparación',
                                valor: registro['fechaReparacion']),
                            TextoInspeccion(
                                leyenda: 'Hora de reparación',
                                valor: registro['horaReparacion']),
                            TextoInspeccion(
                                leyenda:
                                    'fecha de comprobación de la reparación',
                                valor: registro['fechaComprobacionReparacion']),
                            TextoInspeccion(
                                leyenda:
                                    'Hora de comprobación de la reparación',
                                valor: registro['horaComprobacionReparacion']),
                            TextoInspeccion(
                                leyenda:
                                    'concentracion posterior a la reparacion',
                                valor: registro[
                                    'concentracionPosteriorReparacion']),

                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            const Center(
                              child: Text(
                                'Reparado No',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            TextoInspeccion(
                                leyenda:
                                    'No Reparado por falta de componentes?',
                                valor: registro['noReparadofaltaComponentes']),
                            TextoInspeccion(
                                leyenda: 'fecha de remisión del Componente',
                                valor: registro['fechaRemisionComponente']),
                            TextoInspeccion(
                                leyenda: 'fecha de reparación del Componente',
                                valor: registro['fechaReparacionComponente']),
                            TextoInspeccion(
                                leyenda: 'fecha de remplazo del equipo',
                                valor: registro['fechaRemplazoEquipo']),
                            TextoInspeccion(
                                leyenda: 'volumen de Metano',
                                valor: registro['volumenMetano']),

                            TextoInspeccion(
                              leyenda: 'Subido',
                              valor: registro['subidoNube'].toString(),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            const Center(
                              child: Text(
                                'Datos Fuga',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            TextoInspeccion(
                                leyenda: '¿Fuga?', valor: registro['fuga']),
                            TextoInspeccion(
                                leyenda: 'Observación personal',
                                valor: registro['observacionPersonal']),
                            TextoInspeccion(
                                leyenda: 'Observación',
                                valor: registro['observacion']),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los datos'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> obtenerRegistrosSeccionII(
      int clienteId) async {
    final List<Map<String, dynamic>> datosIns =
        await getDataFromTable('anexocinco');
    final List<Map<String, dynamic>> registros = [];

    for (var registro in datosIns) {
      if (registro['clienteID'] == clienteId) {
        registros.add(registro);
      }
    }
    return registros;
  }
}

class TextoInspeccion extends StatelessWidget {
  final String leyenda;
  final String valor;

  const TextoInspeccion(
      {super.key, required this.leyenda, required this.valor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Text(
            '$leyenda: $valor',
            textAlign: TextAlign.justify,
            maxLines: 20,
          ),
        ),
        const SizedBox(
          height: 7,
        )
      ],
    );
  }
}
