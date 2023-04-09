import 'package:flutter/material.dart';
import 'package:iktanambiental/src/theme/timepicker_theme.dart';

class CampoHora extends StatefulWidget {
  final TextEditingController controlador;
  final String hinText;

  const CampoHora(
      {super.key, required this.controlador, required this.hinText});
  @override
  State<CampoHora> createState() => _CampoHoraState();
}

class _CampoHoraState extends State<CampoHora> {
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
            contentPadding: const EdgeInsets.only(top: 14),
            prefixIcon: const Icon(
              Icons.email,
              color: Colors.white,
            ),
            hintText: widget.hinText,
            hintStyle: const TextStyle(color: Colors.black38),
          ),
          onTap: () => {
            FocusScope.of(context).requestFocus(FocusNode()),
            selectTime(context),
          },
        ),
      ),
    );
  }

  selectTime(BuildContext context) {
    String hora;
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      //helpText: 'Selecciona la hora',
      cancelText: 'Cancelar',
      confirmText: 'Confirmar',
      builder: (context, child) {
        return temaDatePicker(context, child);
      },
    ).then((value) => setState(() {
          hora = value.toString();
          if ((value == null)) {
            widget.controlador.text = '';
          } else {
            widget.controlador.text = hora.substring(10, 15);
          }
        }));
  }
}
