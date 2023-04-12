import 'package:flutter/material.dart';
import 'package:iktanambiental/src/widgets/widgets.dart';

class ReparadoSi extends StatelessWidget {
  const ReparadoSi({
    super.key,
    required this.fechaReparacion,
    required this.horaReparacion,
    required this.fechaComprobacionReparacion,
    required this.horaComprobacionReparacion,
  });

  final TextEditingController fechaReparacion;
  final TextEditingController horaReparacion;
  final TextEditingController fechaComprobacionReparacion;
  final TextEditingController horaComprobacionReparacion;

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
      ],
    );
  }
}
