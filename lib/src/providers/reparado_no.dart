import 'package:flutter/material.dart';

class NoReparadoProvider with ChangeNotifier {
  String noReparado = '';

  get getNoReparado {
    return noReparado;
  }

  set setNoReparado(String noRep) {
    noReparado = noRep;
    notifyListeners();
  }
}
