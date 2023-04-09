import 'package:flutter/material.dart';
import 'package:iktanambiental/src/widgets/widgets.dart';

class ReparadoNo extends StatefulWidget {
  const ReparadoNo({
    super.key,
    required this.noReparadofaltaComponentes,
    required this.fechaRemisionComponente,
    required this.fechaReperacionComponente,
    required this.fechaRemplazoEquipo,
    required this.volumenMetano,
  });

  // NO REPARADO
  final TextEditingController noReparadofaltaComponentes;
  final TextEditingController fechaRemisionComponente;
  final TextEditingController fechaReperacionComponente;
  final TextEditingController fechaRemplazoEquipo;
  final TextEditingController volumenMetano;

  @override
  State<ReparadoNo> createState() => _ReparadoNoState();
}

class _ReparadoNoState extends State<ReparadoNo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AlertaNoReparadoFaltaComponentes(
          valorCampo: widget.noReparadofaltaComponentes,
          hinText: 'No Reparado por falta de componentes',
        ),
        const SizedBox(
          height: 15,
        ),
        CampoFecha(
            controlador: widget.fechaRemisionComponente,
            hinText: 'Fecha de remisión componente'),
        const SizedBox(
          height: 15,
        ),
        CampoFecha(
            controlador: widget.fechaReperacionComponente,
            hinText: 'Fecha de reparación componente'),
        const SizedBox(
          height: 15,
        ),
        CampoFecha(
            controlador: widget.fechaRemplazoEquipo,
            hinText: 'Fecha de remplazo del componente'),
        const SizedBox(
          height: 15,
        ),
        CampoTexto(
            textoController: widget.volumenMetano,
            hinText: 'Volumen de Metano'),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

class CampoTexto extends StatelessWidget {
  final TextEditingController textoController;
  final String hinText;

  const CampoTexto(
      {super.key, required this.textoController, required this.hinText});

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
          controller: textoController,
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

class AlertaNoReparadoFaltaComponentes extends StatelessWidget {
  const AlertaNoReparadoFaltaComponentes(
      {super.key, required this.valorCampo, required this.hinText});

  final TextEditingController valorCampo;
  final String hinText;

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
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Sí"),
              onPressed: () {
                valorCampo.text = 'Si';
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
