import 'package:flutter/widgets.dart';

import 'local.dart';

class Categoria {
  const Categoria({
    required this.nome,
    required this.icone,
    required this.locais,
    this.mostrarQuantidade = true,
  });

  final String nome;
  final IconData icone;
  final List<Local> locais;
  final bool mostrarQuantidade;
}
