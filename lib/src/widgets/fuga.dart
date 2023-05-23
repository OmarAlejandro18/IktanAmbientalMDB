import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iktanambiental/src/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';

class Fuga extends StatelessWidget {
  const Fuga({
    super.key,
    required this.fuga,
    required this.reparado,

    // REPARADO SI
    required this.fechaReparacion,
    required this.horaReparacion,
    required this.fechaComprobacionReparacion,
    required this.horaComprobacionReparacion,
    required this.concentracionPosteriorReparacion,

    // REPARADO NO
    required this.noReparadofaltaComponentes,
    required this.fechaRemisionComponente,
    required this.fechaReparacionComponente,
    required this.fechaRemplazoEquipo,
    required this.volumenMetano,
  });

  final TextEditingController fuga;

  final TextEditingController reparado;
  final TextEditingController fechaReparacion;
  final TextEditingController horaReparacion;
  final TextEditingController fechaComprobacionReparacion;
  final TextEditingController horaComprobacionReparacion;
  final TextEditingController concentracionPosteriorReparacion;
  final TextEditingController noReparadofaltaComponentes;
  final TextEditingController fechaRemisionComponente;
  final TextEditingController fechaReparacionComponente;
  final TextEditingController fechaRemplazoEquipo;
  final TextEditingController volumenMetano;

  @override
  Widget build(BuildContext context) {
    final esReparado = Provider.of<ReparadoProvider>(context);
    final hfuga = Provider.of<FugaProvider>(context);
    final Size size = MediaQuery.of(context).size;
    final espacioSizedBox = size.width * 0.03;

    return Column(
      children: [
        AlertaFuga(
            valorCampo: fuga,
            hinText: '¿Hay Fuga?',
            reparado: reparado,
            fechaReparacion: fechaReparacion,
            horaReparacion: horaReparacion,
            fechaComprobacionReparacion: fechaComprobacionReparacion,
            horaComprobacionReparacion: horaComprobacionReparacion,
            concentracionPosteriorReparacion: concentracionPosteriorReparacion,
            noReparadofaltaComponentes: noReparadofaltaComponentes,
            fechaRemisionComponente: fechaRemisionComponente,
            fechaReparacionComponente: fechaReparacionComponente,
            fechaRemplazoEquipo: fechaRemplazoEquipo,
            volumenMetano: volumenMetano),
        SizedBox(
          height: size.height * 0.02,
        ),

        hfuga.getFuga == 'Si'
            ? Column(
                children: [
                  Center(
                    child: Text(
                      'Reparaciones',
                      style: TextStyle(
                        fontSize: size.width * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
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
                      fechaReparacionComponente: fechaReparacionComponente,
                      fechaRemplazoEquipo: fechaRemplazoEquipo,
                      volumenMetano: volumenMetano),
                ],
              )
            : Container(),

        SizedBox(
          height: espacioSizedBox,
        ),
        // APARECER EL OTRO FORMULARIO DE REPARADO
        (esReparado.getReparado == '') ? const SizedBox() : const SizedBox(),
        (hfuga.getFuga == 'Si' && esReparado.getReparado == 'Si')
            ? ReparadoSi(
                fechaReparacion: fechaReparacion,
                horaReparacion: horaReparacion,
                fechaComprobacionReparacion: fechaComprobacionReparacion,
                horaComprobacionReparacion: horaComprobacionReparacion,
              )
            : Container(),

        (hfuga.getFuga == 'Si' && esReparado.getReparado == 'No')
            ? ReparadoNo(
                noReparadofaltaComponentes: noReparadofaltaComponentes,
                fechaRemisionComponente: fechaRemisionComponente,
                fechaReparacionComponente: fechaReparacionComponente,
                fechaRemplazoEquipo: fechaRemplazoEquipo,
                volumenMetano: volumenMetano,
              )
            : Container(),
      ],
    );
  }
}

class AlertaFuga extends StatelessWidget {
  const AlertaFuga(
      {super.key,
      required this.valorCampo,
      required this.hinText,
      required this.reparado,
      required this.fechaReparacion,
      required this.horaReparacion,
      required this.fechaComprobacionReparacion,
      required this.horaComprobacionReparacion,
      required this.concentracionPosteriorReparacion,
      required this.noReparadofaltaComponentes,
      required this.fechaRemisionComponente,
      required this.fechaReparacionComponente,
      required this.fechaRemplazoEquipo,
      required this.volumenMetano});

  final TextEditingController valorCampo;
  final String hinText;

  final TextEditingController reparado;
  final TextEditingController fechaReparacion;
  final TextEditingController horaReparacion;
  final TextEditingController fechaComprobacionReparacion;
  final TextEditingController horaComprobacionReparacion;
  final TextEditingController concentracionPosteriorReparacion;
  final TextEditingController noReparadofaltaComponentes;
  final TextEditingController fechaRemisionComponente;
  final TextEditingController fechaReparacionComponente;
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
          controller: valorCampo,
          style: const TextStyle(
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(top: 5, left: 8, right: 5),
            hintText: hinText,
            hintStyle: const TextStyle(color: Colors.black38),
          ),
          onTap: () => {
            FocusScope.of(context).requestFocus(FocusNode()),
            Platform.isIOS ? mostrarAlertaIOS(context) : mostrarAlerta(context),
          },
        ),
      ),
    );
  }

  mostrarAlerta(BuildContext context) {
    final hfuga = Provider.of<FugaProvider>(context, listen: false);
    final esReparado = Provider.of<ReparadoProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(hinText),
          actions: [
            TextButton(
              child: const Text("No"),
              onPressed: () {
                valorCampo.text = 'No';
                reparado.text = '';
                // REPARADO SI
                fechaReparacion.text = '';
                horaReparacion.text = '';
                fechaComprobacionReparacion.text = '';
                horaComprobacionReparacion.text = '';
                // REPARADO NO
                concentracionPosteriorReparacion.text = '';
                noReparadofaltaComponentes.text = '';
                fechaRemisionComponente.text = '';
                fechaReparacionComponente.text = '';
                fechaRemplazoEquipo.text = '';
                volumenMetano.text = '';
                esReparado.setReparado = '';
                hfuga.setFuga = 'No';
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Sí"),
              onPressed: () {
                valorCampo.text = 'Si';
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
                fechaReparacionComponente.text = '';
                fechaRemplazoEquipo.text = '';
                volumenMetano.text = '';
                esReparado.setReparado = '';
                hfuga.setFuga = 'Si';
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  mostrarAlertaIOS(BuildContext context) {
    final hfuga = Provider.of<FugaProvider>(context, listen: false);
    final esReparado = Provider.of<ReparadoProvider>(context, listen: false);
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(hinText),
            actions: [
              TextButton(
                child: const Text("No"),
                onPressed: () {
                  valorCampo.text = 'No';
                  reparado.text = '';
                  // REPARADO SI
                  fechaReparacion.text = '';
                  horaReparacion.text = '';
                  fechaComprobacionReparacion.text = '';
                  horaComprobacionReparacion.text = '';
                  // REPARADO NO
                  concentracionPosteriorReparacion.text = '';
                  noReparadofaltaComponentes.text = '';
                  fechaRemisionComponente.text = '';
                  fechaReparacionComponente.text = '';
                  fechaRemplazoEquipo.text = '';
                  volumenMetano.text = '';
                  esReparado.setReparado = '';
                  hfuga.setFuga = 'No';
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text("Sí"),
                onPressed: () {
                  valorCampo.text = 'Si';
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
                  fechaReparacionComponente.text = '';
                  fechaRemplazoEquipo.text = '';
                  volumenMetano.text = '';
                  esReparado.setReparado = '';
                  hfuga.setFuga = 'Si';
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
