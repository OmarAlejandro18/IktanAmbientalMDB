import 'package:flutter/material.dart';

class Fuga extends StatelessWidget {
  const Fuga(
      {super.key,
      required this.fuga,
      required this.observacionPersonal,
      required this.observacion,
      });

  final TextEditingController fuga;
  final TextEditingController observacionPersonal;
  final TextEditingController observacion;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        AlertaFuga(valorCampo: fuga, hinText: '¿Hay Fuga?'),
        const SizedBox(
          height: 15,
        ),
        CampoObservacion(controlador: observacionPersonal, hinText: 'Observación personal',),
        const SizedBox(
          height: 15,
        ),
        CampoObservacion(controlador: observacion, hinText: 'Observación',),
      ],
    );
  }
}

class AlertaFuga extends StatelessWidget {
  const AlertaFuga(
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

class CampoObservacion extends StatelessWidget {
  final TextEditingController controlador;
  final String hinText;

  const CampoObservacion(
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
        height: 150,
        child: TextFormField(
          maxLines: 40,
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
