import 'package:flutter/material.dart';
import 'package:iktanambiental/src/widgets/widgets.dart';

class ReparadoSi extends StatelessWidget {
  const ReparadoSi(
      {super.key,
      required this.fechaReparacion,
      required this.horaReparacion,
      required this.fechaComprobacionReparacion,
      required this.horaComprobacionReparacion,
      required this.concentracionPosteriorReparacion});

  final TextEditingController fechaReparacion;
  final TextEditingController horaReparacion;
  final TextEditingController fechaComprobacionReparacion;
  final TextEditingController horaComprobacionReparacion;
  final TextEditingController concentracionPosteriorReparacion;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CampoFecha(
            controlador: fechaReparacion, hinText: 'Fecha de reparación'),
        const SizedBox(
          height: 15,
        ),
        CampoHora(
          controlador: horaReparacion,
          hinText: 'Hora de reparación',
        ),
        const SizedBox(
          height: 15,
        ),
        CampoFecha(
            controlador: fechaComprobacionReparacion,
            hinText: 'Fecha de comprobación reparación'),
        const SizedBox(
          height: 15,
        ),
        CampoHora(
          controlador: horaComprobacionReparacion,
          hinText: 'Hora de comprobación reparación',
        ),
        const SizedBox(
          height: 15,
        ),
        ConcentracionPosteriorRepracion(
          concentracionPosteriorReparacion: concentracionPosteriorReparacion,
          hinText: 'Concentración posterior reparación',
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

class ConcentracionPosteriorRepracion extends StatelessWidget {
  final TextEditingController concentracionPosteriorReparacion;
  final String hinText;

  const ConcentracionPosteriorRepracion(
      {super.key,
      required this.concentracionPosteriorReparacion,
      required this.hinText});

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
          controller: concentracionPosteriorReparacion,
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
