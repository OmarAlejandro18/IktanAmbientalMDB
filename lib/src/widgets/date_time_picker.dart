import 'package:flutter/material.dart';
import 'package:iktanambiental/src/theme/timepicker_theme.dart';
import 'package:intl/intl.dart';

class CampoFecha extends StatefulWidget {
  final TextEditingController controlador;
  final String hinText;
  const CampoFecha(
      {super.key, required this.controlador, required this.hinText});

  @override
  State<CampoFecha> createState() => _CampoFechaState();
}

class _CampoFechaState extends State<CampoFecha> {
  DateTime? fechaFormat;

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
          controller: widget.controlador,
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
            selectDate(context)
          },
        ),
      ),
    );
  }

  selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2030),
        locale: const Locale('es', ''),
        builder: (context, child) {
          return temaDatePicker(context, child);
        });

    String fecha;
    if (picked != null) {
      setState(() {
        fechaFormat = picked;
        fecha = DateFormat('dd/MM/yyyy').format(fechaFormat!).toString();
        widget.controlador.text = fecha.substring(0, 10);
      });
    }
  }
}
