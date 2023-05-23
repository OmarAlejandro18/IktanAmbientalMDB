import 'package:flutter/material.dart';
import 'package:iktanambiental/src/providers/providers.dart';
import 'package:iktanambiental/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ReparadoNo extends StatefulWidget {
  const ReparadoNo({
    super.key,
    required this.noReparadofaltaComponentes,
    required this.fechaRemisionComponente,
    required this.fechaReparacionComponente,
    required this.fechaRemplazoEquipo,
    required this.volumenMetano,
  });

  // NO REPARADO
  final TextEditingController noReparadofaltaComponentes;
  final TextEditingController fechaRemisionComponente;
  final TextEditingController fechaReparacionComponente;
  final TextEditingController fechaRemplazoEquipo;
  final TextEditingController volumenMetano;

  @override
  State<ReparadoNo> createState() => _ReparadoNoState();
}

class _ReparadoNoState extends State<ReparadoNo> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final noRepa = Provider.of<NoReparadoProvider>(context);
    return Column(
      children: [
        DropdownNoPudoSerReparadoPorFalta(
          valorCampo: widget.noReparadofaltaComponentes,
          hinText: '¿No pudo ser reparado por falta de componentes?',
          fechaRemisionComponente: widget.fechaRemisionComponente,
          fechaReparacionComponente: widget.fechaReparacionComponente,
          fechaRemplazoEquipo: widget.fechaRemplazoEquipo,
        ),
        noRepa.getNoReparado == 'Si'
            ? NoReparadoPorFaltaComponentesSi(
                fechaRemisionComponente: widget.fechaRemisionComponente,
                fechaReparacionComponente: widget.fechaReparacionComponente,
                fechaRemplazoEquipo: widget.fechaRemplazoEquipo)
            : Container(),
        SizedBox(
          height: size.height * 0.02,
        ),
        CampoTexto(
            textoController: widget.volumenMetano,
            hinText: 'Volumen de Metano'),
        SizedBox(
          height: size.height * 0.02,
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
            contentPadding: const EdgeInsets.only(top: 5, left: 8, right: 5),
            hintText: hinText,
            hintStyle: const TextStyle(color: Colors.black38),
          ),
        ),
      ),
    );
  }
}

class DropdownNoPudoSerReparadoPorFalta extends StatefulWidget {
  const DropdownNoPudoSerReparadoPorFalta(
      {super.key,
      required this.fechaRemisionComponente,
      required this.fechaReparacionComponente,
      required this.fechaRemplazoEquipo,
      required this.valorCampo,
      required this.hinText});

  final TextEditingController fechaRemisionComponente;
  final TextEditingController fechaReparacionComponente;
  final TextEditingController fechaRemplazoEquipo;

  final TextEditingController valorCampo;
  final String hinText;

  @override
  State<DropdownNoPudoSerReparadoPorFalta> createState() =>
      _DropdownNoPudoSerReparadoPorFaltaState();
}

class _DropdownNoPudoSerReparadoPorFaltaState
    extends State<DropdownNoPudoSerReparadoPorFalta> {
  String? _dropdownValue;

  @override
  Widget build(BuildContext context) {
    final noRepa = Provider.of<NoReparadoProvider>(context, listen: false);
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
        child: DropdownButtonFormField(
          style: const TextStyle(
            color: Colors.black,
          ),
          value: _dropdownValue,
          onChanged: (value) {
            setState(() {
              _dropdownValue = value!;
              widget.valorCampo.text = _dropdownValue!;
              noRepa.setNoReparado = widget.valorCampo.text;
              widget.fechaRemisionComponente.text = '';
              widget.fechaReparacionComponente.text = '';
              widget.fechaRemplazoEquipo.text = '';
            });
          },
          items: const [
            DropdownMenuItem(
              value: 'Si',
              child: Text('Si'),
            ),
            DropdownMenuItem(
              value: 'No',
              child: Text('No'),
            ),
            DropdownMenuItem(
              value: 'N/A',
              child: Text('N/A'),
            ),
          ],
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 8, right: 5),
            labelText: '¿No pudo ser reparado por falta de componentes?',
            labelStyle: TextStyle(
              color: Colors.black38, // Aquí se cambia el color del labelText
            ),
          ),
        ),
      ),
    );
  }
}

class NoReparadoPorFaltaComponentesSi extends StatelessWidget {
  const NoReparadoPorFaltaComponentesSi(
      {super.key,
      required this.fechaRemisionComponente,
      required this.fechaReparacionComponente,
      required this.fechaRemplazoEquipo});

  final TextEditingController fechaRemisionComponente;
  final TextEditingController fechaReparacionComponente;
  final TextEditingController fechaRemplazoEquipo;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.02,
        ),
        CampoFecha(
            controlador: fechaRemisionComponente,
            hinText: 'Fecha de remisión componente'),
        SizedBox(
          height: size.height * 0.02,
        ),
        CampoFecha(
            controlador: fechaReparacionComponente,
            hinText: 'Fecha de reparación componente'),
        SizedBox(
          height: size.height * 0.02,
        ),
        CampoFecha(
            controlador: fechaRemplazoEquipo,
            hinText: 'Fecha de remplazo del componente'),
      ],
    );
  }
}
