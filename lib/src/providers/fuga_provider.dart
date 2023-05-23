import 'package:flutter/material.dart';

class FugaProvider with ChangeNotifier {
  String fugas = 'null';

  get getFuga {
    return fugas;
  }

  set setFuga(String fuga) {
    fugas = fuga;
    notifyListeners();
  }
}
