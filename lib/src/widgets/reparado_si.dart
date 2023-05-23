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
    final Size size = MediaQuery.of(context).size;
    final espaciosSizedBox = size.height * 0.02;
    return Column(
      children: [
        CampoFecha(
            controlador: fechaReparacion, hinText: 'Fecha de reparación'),
        SizedBox(
          height: espaciosSizedBox,
        ),
        CampoHora(
          controlador: horaReparacion,
          hinText: 'Hora de reparación',
        ),
        SizedBox(
          height: espaciosSizedBox,
        ),
        CampoFecha(
            controlador: fechaComprobacionReparacion,
            hinText: 'Fecha de comprobación reparación'),
        SizedBox(
          height: espaciosSizedBox,
        ),
        CampoHora(
          controlador: horaComprobacionReparacion,
          hinText: 'Hora de comprobación reparación',
        ),
        SizedBox(
          height: espaciosSizedBox,
        ),
      ],
    );
  }
}
