import 'package:flutter/material.dart';

class ReparadoProvider with ChangeNotifier {
  String reparado = '';

  get getReparado {
    return reparado;
  }

  set setReparado(String rep) {
    reparado = rep;
    notifyListeners();
  }
}
