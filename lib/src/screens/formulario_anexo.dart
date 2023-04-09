import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iktanambiental/src/db/insertar_anexo.dart';
import 'package:iktanambiental/src/models/anexocinco_model.dart';
import 'package:iktanambiental/src/providers/providers.dart';
import 'package:iktanambiental/src/screens/screens.dart';
import 'package:iktanambiental/src/theme/app_tema.dart';
import 'package:iktanambiental/src/widgets/image_picker.dart';
import 'package:iktanambiental/src/widgets/reparado_no.dart';
import 'package:iktanambiental/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class FormularioAnexoScreen extends StatefulWidget {
  const FormularioAnexoScreen(
      {super.key, required this.clienteID, required this.trimestre});

  final int clienteID;
  final String trimestre;

  @override
  State<FormularioAnexoScreen> createState() => _FormularioAnexoScreenState();
}

class _FormularioAnexoScreenState extends State<FormularioAnexoScreen> {
  final _formKey = GlobalKey<FormState>();

  final nombreInstalacion = TextEditingController();
  final idComponente = TextEditingController();
  final ubicacionInstalacion = TextEditingController();
  final equipoCritico = TextEditingController();
  final inspeccionTecnicaRiesgo = TextEditingController();

  // DATOS INSPECCIÓN
  final nombrePersonal = TextEditingController();
  final fechaInicioInspeccion = TextEditingController();
  final horaInicioInspeccion = TextEditingController();
  final fechafinalizacionInspeccion = TextEditingController();
  final horafinalizacionInspeccion = TextEditingController();
  final velocidadViento = TextEditingController();
  final temperatura = TextEditingController();
  final instrumentoUtilizado = TextEditingController();
  final fechaCalibracion = TextEditingController();
  final desviacionProcedimiento = TextEditingController();
  final justificacionDesviacion = TextEditingController();
  final interferenciaDeteccion = TextEditingController();
  final concentracionPrevia = TextEditingController();
  final reparado = TextEditingController();

  // REPARADO SI
  final fechaReparacion = TextEditingController();
  final horaReparacion = TextEditingController();
  final fechaComprobacionReparacion = TextEditingController();
  final horaComprobacionReparacion = TextEditingController();
  final concentracionPosteriorReparacion = TextEditingController();

  // REPARADO NO
  final noReparadofaltaComponentes = TextEditingController();
  final fechaRemisionComponente = TextEditingController();
  final fechaReperacionComponente = TextEditingController();
  final fechaRemplazoEquipo = TextEditingController();
  final volumenMetano = TextEditingController();

  // FUGA
  final fuga = TextEditingController();
  final observacionPersonal = TextEditingController();
  final observacion = TextEditingController();

  // FOTOS
  final imagen = TextEditingController();
  final imagenInfrarroja = TextEditingController();

  late File imgUploadF;
  XFile? imageF;
  late File imgUploadT;
  XFile? imageT;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final esReparado = Provider.of<ReparadoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingresa Los Datos del Anexo 5'),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Datos de la Instalación',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 15,
                ),
                CampoInstalacion(
                  controlador: nombreInstalacion,
                  hinText: 'Nombre de la Instalación',
                ),
                const SizedBox(
                  height: 15,
                ),
                CampoInstalacion(
                  controlador: idComponente,
                  hinText: 'ID del componente',
                ),
                const SizedBox(
                  height: 15,
                ),
                CampoInstalacion(
                  controlador: ubicacionInstalacion,
                  hinText: 'Ubicación de la Instalación',
                ),
                const SizedBox(
                  height: 15,
                ),
                AlertaInstalacion(
                    valorCampo: equipoCritico, hinText: 'Equipo Critico'),
                const SizedBox(
                  height: 15,
                ),
                AlertaInstalacion(
                    valorCampo: inspeccionTecnicaRiesgo,
                    hinText: 'Inspección Tecnica de Riesgo'),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Datos de la inspección',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 15,
                ),
                CampoInspeccion(
                  controlador: nombrePersonal,
                  hinText: 'Nombre del personal',
                ),
                const SizedBox(
                  height: 15,
                ),
                CampoFecha(
                  controlador: fechaInicioInspeccion,
                  hinText: 'Fecha de inicio de la inspección',
                ),
                const SizedBox(
                  height: 15,
                ),
                CampoHora(
                  controlador: horaInicioInspeccion,
                  hinText: 'Hora de inicio de la inspección',
                ),
                const SizedBox(
                  height: 15,
                ),
                CampoFecha(
                  controlador: fechafinalizacionInspeccion,
                  hinText: 'Fecha final de la inspección',
                ),
                const SizedBox(
                  height: 15,
                ),
                CampoHora(
                  controlador: horafinalizacionInspeccion,
                  hinText: 'Hora final de la inspección',
                ),
                const SizedBox(
                  height: 15,
                ),
                CampoInspeccion(
                    controlador: velocidadViento, hinText: 'Velocidad/Viento'),
                const SizedBox(
                  height: 15,
                ),
                CampoInspeccion(
                    controlador: temperatura, hinText: 'Temperatura'),
                const SizedBox(
                  height: 15,
                ),
                CampoInspeccion(
                    controlador: instrumentoUtilizado,
                    hinText: 'Instrumento Utilizado'),
                const SizedBox(
                  height: 15,
                ),
                CampoFecha(
                    controlador: fechaCalibracion,
                    hinText: 'Fecha de la Calibración'),
                const SizedBox(
                  height: 15,
                ),
                CampoInspeccion(
                    controlador: desviacionProcedimiento,
                    hinText: 'Desviación procedimiento'),
                const SizedBox(
                  height: 15,
                ),
                CampoInspeccion(
                    controlador: justificacionDesviacion,
                    hinText: 'Justificación de la desviación'),
                const SizedBox(
                  height: 15,
                ),
                CampoInspeccion(
                    controlador: interferenciaDeteccion,
                    hinText: 'Interferencia detección'),
                const SizedBox(
                  height: 15,
                ),
                CampoInspeccion(
                    controlador: concentracionPrevia,
                    hinText: 'Concentración previa'),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Reparación',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 15,
                ),
                CampoPudoSerRapado(
                    reparado: reparado,
                    hinText: '¿Pudo Ser Reparado?',
                    fechaReparacion: fechaReparacion,
                    horaReparacion: horaReparacion,
                    fechaComprobacionReparacion: fechaComprobacionReparacion,
                    horaComprobacionReparacion: horaComprobacionReparacion,
                    concentracionPosteriorReparacion:
                        concentracionPosteriorReparacion,
                    noReparadofaltaComponentes: noReparadofaltaComponentes,
                    fechaRemisionComponente: fechaRemisionComponente,
                    fechaReperacionComponente: fechaReperacionComponente,
                    fechaRemplazoEquipo: fechaRemplazoEquipo,
                    volumenMetano: volumenMetano),
                const SizedBox(
                  height: 15,
                ),
                // APARECER EL OTRO FORMULARIO DE REPARADO
                (esReparado.getReparado == '')
                    ? const SizedBox()
                    : const SizedBox(),
                (esReparado.getReparado == 'Si')
                    ? ReparadoSi(
                        fechaReparacion: fechaReparacion,
                        horaReparacion: horaReparacion,
                        fechaComprobacionReparacion:
                            fechaComprobacionReparacion,
                        horaComprobacionReparacion: horaComprobacionReparacion,
                        concentracionPosteriorReparacion:
                            concentracionPosteriorReparacion)
                    : Container(),
                (esReparado.getReparado == 'No')
                    ? ReparadoNo(
                        noReparadofaltaComponentes: noReparadofaltaComponentes,
                        fechaRemisionComponente: fechaRemisionComponente,
                        fechaReperacionComponente: fechaReperacionComponente,
                        fechaRemplazoEquipo: fechaRemplazoEquipo,
                        volumenMetano: volumenMetano)
                    : Container(),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Fuga',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 15,
                ),
                Fuga(
                  fuga: fuga,
                  observacionPersonal: observacionPersonal,
                  observacion: observacion,
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Fotos',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: size.width * 0.85,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: () async {
                        imageF = await cargarFotoFirestore();
                        if (imageF == null) {
                          imagen.text = 'null';
                        } else {
                          setState(() {
                            imgUploadF = File(imageF!.path);
                            imagen.text = imgUploadF.path;
                          });
                        }
                      },
                      child: const Text('Tomar Fotografía')),
                ),
                imagen.text != 'null' && imagen.text != ''
                    ? SizedBox(
                        width: 200,
                        height: 100,
                        child: (imagen.text != 'null' && imagen.text != '')
                            ? Image.file(imgUploadF)
                            : const Text(''),
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: size.width * 0.85,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: () async {
                        imageT = await cargarFotoTermograficaFirestore();
                        if (imageT == null) {
                          imagenInfrarroja.text = 'null';
                        } else {
                          setState(() {
                            imgUploadT = File(imageT!.path);
                            imagenInfrarroja.text = imgUploadT.path;
                          });
                        }
                      },
                      child: const Text('Tomar Fotografía Infrarroja')),
                ),
                imagenInfrarroja.text != 'null' && imagenInfrarroja.text != ''
                    ? SizedBox(
                        width: 200,
                        height: 100,
                        child: (imagenInfrarroja.text != 'null' &&
                                imagenInfrarroja.text != '')
                            ? Image.file(imgUploadT)
                            : const Text(''),
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 30,
                ),

                // ENVIAR DATOS

                SizedBox(
                  width: size.width * 0.85,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () async {
                      print('el id del cliente es ${widget.clienteID}');
                      print('el trimestre es ${widget.trimestre}');
                      InsertarAnexoCinco().insertarAnexoCinco(AnexoCinco(
                        anexoID: DateTime.now().millisecondsSinceEpoch ~/ 1000,
                        // INSTALACION
                        nombreInstalacion: nombreInstalacion.text,
                        idComponente: idComponente.text,
                        ubicacionInstalacion: ubicacionInstalacion.text,
                        equipoCritico: equipoCritico.text,
                        inspeccionTecnicaRiesgo: inspeccionTecnicaRiesgo.text,

                        // INSPECCION
                        nombrePersonal: nombrePersonal.text,
                        fechaInicioInspeccion: fechaInicioInspeccion.text,
                        horaInicioInspeccion: horaInicioInspeccion.text,
                        fechafinalizacionInspeccion:
                            fechafinalizacionInspeccion.text,
                        horafinalizacionInspeccion:
                            horafinalizacionInspeccion.text,
                        velocidadViento: velocidadViento.text,
                        temperatura: temperatura.text,
                        instrumentoUtilizado: instrumentoUtilizado.text,
                        fechaCalibracion: fechaCalibracion.text,
                        desviacionProcedimiento: desviacionProcedimiento.text,
                        justificacionDesviacion: justificacionDesviacion.text,
                        interferenciaDeteccion: interferenciaDeteccion.text,
                        concentracionPrevia: concentracionPrevia.text,
                        reparado: reparado.text,

                        // REPARADO SI
                        fechaReparacion: fechaReparacion.text,
                        horaReparacion: horaReparacion.text,
                        fechaComprobacionReparacion:
                            fechaComprobacionReparacion.text,
                        horaComprobacionReparacion:
                            horaComprobacionReparacion.text,
                        concentracionPosteriorReparacion:
                            concentracionPosteriorReparacion.text,

                        // REPARADO NO
                        noReparadofaltaComponentes:
                            noReparadofaltaComponentes.text,
                        fechaRemisionComponente: fechaRemisionComponente.text,
                        fechaReperacionComponente:
                            fechaReperacionComponente.text,
                        fechaRemplazoEquipo: fechaRemplazoEquipo.text,
                        volumenMetano: volumenMetano.text,

                        // FUGA
                        fuga: fuga.text,
                        observacionPersonal: observacionPersonal.text,
                        observacion: observacion.text,

                        // IMAGENES
                        imagen: imagen.text,
                        imagenInfrarroja: imagenInfrarroja.text,

                        anexoURL: '',
                        informeURL: '',
                        trimestre: widget.trimestre,

                        clienteID: widget.clienteID,
                      ));

                      // INSTALACION
                      nombreInstalacion.text = '';
                      idComponente.text = '';
                      ubicacionInstalacion.text = '';
                      equipoCritico.text = '';
                      inspeccionTecnicaRiesgo.text = '';

                      // INSPECCION
                      nombrePersonal.text = '';
                      fechaInicioInspeccion.text = '';
                      horaInicioInspeccion.text = '';
                      fechafinalizacionInspeccion.text = '';
                      horafinalizacionInspeccion.text = '';
                      velocidadViento.text = '';
                      temperatura.text = '';
                      instrumentoUtilizado.text = '';
                      fechaCalibracion.text = '';
                      desviacionProcedimiento.text = '';
                      justificacionDesviacion.text = '';
                      interferenciaDeteccion.text = '';
                      concentracionPrevia.text = '';
                      reparado.text = '';

                      // REPARADO SI
                      fechaReparacion.text = '';
                      horaReparacion.text = '';
                      fechaComprobacionReparacion.text = '';
                      horaComprobacionReparacion.text = '';
                      concentracionPosteriorReparacion.text = '';

                      // REPARADO NO
                      noReparadofaltaComponentes.text = '';
                      fechaRemisionComponente.text = '';
                      fechaReperacionComponente.text = '';
                      fechaRemplazoEquipo.text = '';
                      volumenMetano.text = '';

                      // FUGA

                      fuga.text = '';
                      observacionPersonal.text = '';
                      observacion.text = '';

                      // IMAGENES
                      imagen.text = '';
                      imagenInfrarroja.text = '';

                      //Navigator.popUntil(context, ModalRoute.withName('inicio'));
                      //Navigator.pushNamed(context, 'home');

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      );
                    },
                    child: const Text('Guardar Datos Anexo V'),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            )),
      ),
    );
  }
}

class CampoInstalacion extends StatelessWidget {
  final TextEditingController controlador;
  final String hinText;

  const CampoInstalacion(
      {super.key, required this.controlador, required this.hinText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              offset: Offset(4, -4),
              blurRadius: 6,
              color: Colors.black26,
            ),
          ],
        ),
        height: 60,
        child: TextFormField(
          controller: controlador,
          style: const TextStyle(
            color: Colors.black87,
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Por favor ingrese $hinText';
            }
            return null;
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(top: 14),
            prefixIcon: const Icon(
              Icons.email,
              color: Colors.white,
            ),
            hintText: hinText,
            hintStyle: const TextStyle(color: Colors.black38),
          ),
        ),
      ),
    );
  }
}

class CampoInspeccion extends StatelessWidget {
  final TextEditingController controlador;
  final String hinText;
  const CampoInspeccion(
      {super.key, required this.controlador, required this.hinText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              offset: Offset(4, -4),
              blurRadius: 6,
              color: Colors.black26,
            ),
          ],
        ),
        height: 60,
        child: TextFormField(
          controller: controlador,
          style: const TextStyle(
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(top: 14),
            prefixIcon: const Icon(
              Icons.email,
              color: Colors.white,
            ),
            hintText: hinText,
            hintStyle: const TextStyle(color: Colors.black38),
          ),
        ),
      ),
    );
  }
}

class CampoPudoSerRapado extends StatelessWidget {
  const CampoPudoSerRapado({
    super.key,
    required this.reparado,
    required this.hinText,
    required this.fechaReparacion,
    required this.horaReparacion,
    required this.fechaComprobacionReparacion,
    required this.horaComprobacionReparacion,
    required this.concentracionPosteriorReparacion,
    required this.noReparadofaltaComponentes,
    required this.fechaRemisionComponente,
    required this.fechaReperacionComponente,
    required this.fechaRemplazoEquipo,
    required this.volumenMetano,
  });

  final TextEditingController reparado;
  final String hinText;

  //REPARADO SI
  final TextEditingController fechaReparacion;
  final TextEditingController horaReparacion;
  final TextEditingController fechaComprobacionReparacion;
  final TextEditingController horaComprobacionReparacion;
  final TextEditingController concentracionPosteriorReparacion;

  // REPARADO NO
  final TextEditingController noReparadofaltaComponentes;
  final TextEditingController fechaRemisionComponente;
  final TextEditingController fechaReperacionComponente;
  final TextEditingController fechaRemplazoEquipo;
  final TextEditingController volumenMetano;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              offset: Offset(4, -4),
              blurRadius: 6,
              color: Colors.black26,
            ),
          ],
        ),
        height: 60,
        child: TextFormField(
          controller: reparado,
          style: const TextStyle(
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(top: 14),
            prefixIcon: const Icon(
              Icons.email,
              color: Colors.white,
            ),
            hintText: hinText,
            hintStyle: const TextStyle(color: Colors.black38),
          ),
          onTap: () => {
            FocusScope.of(context).requestFocus(FocusNode()),
            mostrarAlerta(context),
          },
        ),
      ),
    );
  }

  mostrarAlerta(BuildContext context) {
    final fueReperado = Provider.of<ReparadoProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("¿Pudo ser reparado?"),
          actions: [
            TextButton(
              child: const Text("No"),
              onPressed: () {
                reparado.text = 'No';
                fueReperado.setReparado = reparado.text;
                // REPARADO SI
                fechaReparacion.text = '';
                horaReparacion.text = '';
                fechaComprobacionReparacion.text = '';
                horaComprobacionReparacion.text = '';
                concentracionPosteriorReparacion.text = '';
                //REPARADO NO
                noReparadofaltaComponentes.text = '';
                fechaRemisionComponente.text = '';
                fechaReperacionComponente.text = '';
                fechaRemplazoEquipo.text = '';
                volumenMetano.text = '';
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Sí"),
              onPressed: () {
                //REPARADO SI
                reparado.text = 'Si';
                fueReperado.setReparado = reparado.text;
                fechaReparacion.text = '';
                horaReparacion.text = '';
                fechaComprobacionReparacion.text = '';
                horaComprobacionReparacion.text = '';
                concentracionPosteriorReparacion.text = '';
                //REPARADO NO
                noReparadofaltaComponentes.text = '';
                fechaRemisionComponente.text = '';
                fechaReperacionComponente.text = '';
                fechaRemplazoEquipo.text = '';
                volumenMetano.text = '';
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
