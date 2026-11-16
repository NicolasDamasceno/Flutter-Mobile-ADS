import 'package:flutter/foundation.dart';

import '../models/local.dart';

class SalvosController extends ChangeNotifier {
  final List<Local> _salvos = [];

  List<Local> get salvos => List.unmodifiable(_salvos);

  bool estaSalvo(Local local) => _salvos.any((salvo) => salvo.id == local.id);

  void alternar(Local local) {
    if (estaSalvo(local)) {
      remover(local);
    } else {
      _salvos.add(local);
      notifyListeners();
    }
  }

  void remover(Local local) {
    _salvos.removeWhere((salvo) => salvo.id == local.id);
    notifyListeners();
  }
}
