import 'package:google_maps_flutter/google_maps_flutter.dart';

class Local {
  const Local({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.endereco,
    required this.posicao,
  });

  final String id;
  final String nome;
  final String descricao;
  final String endereco;
  final LatLng posicao;
}
