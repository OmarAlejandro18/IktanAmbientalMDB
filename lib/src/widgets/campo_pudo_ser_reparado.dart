import 'package:flutter/material.dart';
import 'package:iktanambiental/src/providers/providers.dart';
import 'package:provider/provider.dart';

class CampoPudoSerRapado extends StatefulWidget {
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
    required this.fechaReparacionComponente,
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
  final TextEditingController fechaReparacionComponente;
  final TextEditingController fechaRemplazoEquipo;
  final TextEditingController volumenMetano;

  @override
  State<CampoPudoSerRapado> createState() => _CampoPudoSerRapadoState();
}

class _CampoPudoSerRapadoState extends State<CampoPudoSerRapado> {
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
          controller: widget.reparado,
          style: const TextStyle(
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(top: 5, left: 8, right: 5),
            hintText: widget.hinText,
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
    final noRepa = Provider.of<NoReparadoProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("¿Pudo ser reparado?"),
          actions: [
            TextButton(
              child: const Text("No"),
              onPressed: () {
                setState(() {
                  widget.reparado.text = 'No';
                  fueReperado.setReparado = widget.reparado.text;
                  // REPARADO SI
                  widget.fechaReparacion.text = '';
                  widget.horaReparacion.text = '';
                  widget.fechaComprobacionReparacion.text = '';
                  widget.horaComprobacionReparacion.text = '';
                  widget.concentracionPosteriorReparacion.text = '';
                  //REPARADO NO
                  widget.noReparadofaltaComponentes.text = '';
                  widget.fechaRemisionComponente.text = '';
                  widget.fechaReparacionComponente.text = '';
                  widget.fechaRemplazoEquipo.text = '';
                  widget.volumenMetano.text = '';
                  noRepa.setNoReparado = '';
                });

                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Sí"),
              onPressed: () {
                setState(() {
                  //REPARADO SI
                  widget.reparado.text = 'Si';
                  fueReperado.setReparado = widget.reparado.text;
                  widget.fechaReparacion.text = '';
                  widget.horaReparacion.text = '';
                  widget.fechaComprobacionReparacion.text = '';
                  widget.horaComprobacionReparacion.text = '';
                  widget.concentracionPosteriorReparacion.text = '';
                  //REPARADO NO
                  widget.noReparadofaltaComponentes.text = 'null';
                  widget.fechaRemisionComponente.text = '';
                  widget.fechaReparacionComponente.text = '';
                  widget.fechaRemplazoEquipo.text = '';
                  widget.volumenMetano.text = '';
                  noRepa.setNoReparado = '';
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
