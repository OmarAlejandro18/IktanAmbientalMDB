import 'package:flutter/material.dart';
import 'package:iktanambiental/src/db/insertar_cliente.dart';
import 'package:iktanambiental/src/db/obtener_datos.dart';
import 'package:iktanambiental/src/models/cliente_model.dart';
import 'package:iktanambiental/src/providers/providers.dart';
import 'package:iktanambiental/src/screens/screens.dart';
import 'package:iktanambiental/src/theme/app_tema.dart';
import 'package:provider/provider.dart';

class ClienteScreen extends StatefulWidget {
  const ClienteScreen({super.key});
  @override
  State<ClienteScreen> createState() => _ClienteScreenState();
}

class _ClienteScreenState extends State<ClienteScreen> {
  final _formKey = GlobalKey<FormState>();
  final clienteID = TextEditingController();
  final cliente = TextEditingController();
  final ciudad = TextEditingController();
  final trimestre = TextEditingController();
  final idDespues = TextEditingController();
  final FocusNode _dropdownFocusNode = FocusNode();
  Cliente? _selectedCliente;

  final List<DropdownMenuItem<Cliente>> _clientDropdownItems = [
    const DropdownMenuItem<Cliente>(
      value: null,
      child: Text("Crear nuevo cliente"),
    ),
  ];

  @override
  void initState() {
    super.initState();
    getClients();
    idDespues.text = '';
  }

  void getClients() async {
    final clientsData = await getDataFromTable('cliente');

    if (clientsData.isNotEmpty) {
      final List<Cliente> clients =
          clientsData.map((data) => Cliente.fromMap(data)).toList();
      _clientDropdownItems.addAll(clients.map((client) {
        return DropdownMenuItem<Cliente>(
          value: client,
          child: Text(client.cliente),
        );
      }).toList());
      if (_selectedCliente == null && clients.isNotEmpty) {
        setState(() {
          _selectedCliente = clients[0];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final hayCliente = Provider.of<ClienteProvider>(context);
    final btnN = Provider.of<BotonClienteProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Clientes')),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Padding(
                  padding:
                      EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 25),
                  child: Text(
                      "Selecciona una opción, en caso de no estar la opción que requiere seleccione 'Crear nuevo cliente'")),
              Padding(
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
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: DropdownButtonFormField<Cliente>(
                      focusNode: _dropdownFocusNode,
                      value: _selectedCliente,
                      items: _clientDropdownItems,
                      onChanged: (value) {
                        if (value == null) {
                          btnN.setTextBoton = 'Si';
                          hayCliente.setCliente = 'No';
                          idDespues.text =
                              (DateTime.now().millisecondsSinceEpoch ~/ 1000)
                                  .toString();
                          cliente.text = '';
                          ciudad.text = '';
                          trimestre.text = '';
                        } else {
                          setState(() {
                            btnN.setTextBoton = 'No';
                            hayCliente.setCliente = 'Si';
                            _selectedCliente = value;
                            clienteID.text = value.clienteID.toString();
                            idDespues.text = '';
                            cliente.text = value.cliente;
                            ciudad.text = value.ciudad;
                            trimestre.text = value.trimestre;
                          });
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Selecciona el Cliente',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 20),
                      ),
                    ),
                  ),
                ),
              ),
              hayCliente.getCliente != null && hayCliente.getCliente != ''
                  ? NuevoClienteForm(
                      clienteID: clienteID,
                      cliente: cliente,
                      ciudad: ciudad,
                      trimestre: trimestre,
                      formKey: _formKey,
                      idDespues: idDespues,
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class NuevoClienteForm extends StatelessWidget {
  const NuevoClienteForm(
      {super.key,
      required this.clienteID,
      required this.cliente,
      required this.ciudad,
      required this.trimestre,
      required this.formKey,
      required this.idDespues});

  final GlobalKey<FormState> formKey;
  final TextEditingController clienteID;
  final TextEditingController cliente;
  final TextEditingController ciudad;
  final TextEditingController trimestre;
  final TextEditingController idDespues;

  @override
  Widget build(BuildContext context) {
    final hayCliente = Provider.of<ClienteProvider>(context);
    final btnN = Provider.of<BotonClienteProvider>(context);
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.05,
        ),
        const Text(
          'Datos del Cliente',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(
          height: size.height * 0.025,
        ),
        EntradaDato(
          controlador: cliente,
          hinText: 'Nombre del cliente',
        ),
        SizedBox(
          height: size.height * 0.025,
        ),
        EntradaDato(
          controlador: ciudad,
          hinText: 'Ciudad',
        ),
        SizedBox(
          height: size.height * 0.025,
        ),
        DropdownTrimestre(
          trimestre: trimestre,
        ),
        SizedBox(
          height: size.height * 0.045,
        ),
        SizedBox(
          width: size.height * 0.30,
          height: size.height * 0.045,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary),
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                if (clienteID.text != '' && idDespues.text == '') {
                  final String trimestreN = trimestre.text;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormularioAnexoScreen(
                        clienteID: int.parse(clienteID.text),
                        trimestre: trimestreN,
                      ),
                    ),
                  );
                }

                if (idDespues.text != '' &&
                    (idDespues.text != clienteID.text)) {
                  final String trimestreN = trimestre.text;
                  InsertarCliente().agregarCliente(
                    Cliente(
                      clienteID: (int.parse(idDespues.text)),
                      cliente: cliente.text,
                      ciudad: ciudad.text,
                      trimestre: trimestre.text,
                    ),
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormularioAnexoScreen(
                        clienteID: int.parse(idDespues.text),
                        trimestre: trimestreN,
                      ),
                    ),
                  );
                }
                cliente.text = '';
                ciudad.text = '';
                trimestre.text = '';
                hayCliente.setCliente = '';
              }
            },
            child: btnN.getTextBoton == 'Si'
                ? const Text(
                    'Guardar Nuevo Cliente',
                    style: TextStyle(color: Colors.white),
                  )
                : const Text('Ir a la inspección',
                    style: TextStyle(color: Colors.white)),
          ),
        )
      ],
    );
  }
}

class EntradaDato extends StatelessWidget {
  final TextEditingController controlador;
  final String hinText;

  const EntradaDato(
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
        height: 60,
        child: TextFormField(
          controller: controlador,
          style: const TextStyle(
            color: Colors.black87,
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Por favor Ingrese $hinText';
            }
            return null;
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(left: 20),
            hintText: hinText,
            hintStyle: const TextStyle(color: Colors.black38),
          ),
        ),
      ),
    );
  }
}

class DropdownTrimestre extends StatefulWidget {
  const DropdownTrimestre({super.key, required this.trimestre});
  final TextEditingController trimestre;
  @override
  State<DropdownTrimestre> createState() => _DropdownTrimestreState();
}

class _DropdownTrimestreState extends State<DropdownTrimestre> {
  String? _dropdownValue;

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
        child: DropdownButtonFormField(
          style: const TextStyle(
            color: Colors.black,
          ),
          value: widget.trimestre.text != ''
              ? widget.trimestre.text
              : _dropdownValue,
          onChanged: (value) {
            setState(() {
              _dropdownValue = value!;
              widget.trimestre.text = _dropdownValue!;
            });
          },
          items: const [
            DropdownMenuItem(
              value: '1',
              child: Text('Trimestre 1'),
            ),
            DropdownMenuItem(
              value: '2',
              child: Text('Trimestre 2'),
            ),
            DropdownMenuItem(
              value: '3',
              child: Text('Trimestre 3'),
            ),
            DropdownMenuItem(
              value: '4',
              child: Text('Trimestre 4'),
            ),
          ],
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 20),
            labelText: 'Seleccione el Trimestre',
            labelStyle: TextStyle(
              color: Colors.black38,
            ),
          ),
        ),
      ),
    );
  }
}
