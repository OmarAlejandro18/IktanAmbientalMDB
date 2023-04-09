import 'package:flutter/material.dart';

class ClienteProvider with ChangeNotifier {
  String clienteSelect = '';

  get getCliente {
    return clienteSelect;
  }

  set setCliente(String cliente) {
    clienteSelect = cliente;
    notifyListeners();
  }
}

class BotonClienteProvider with ChangeNotifier {
  String botonN = 'Si';

  get getTextBoton {
    return botonN;
  }

  set setTextBoton(String botonT) {
    botonN = botonT;
    notifyListeners();
  }
}
