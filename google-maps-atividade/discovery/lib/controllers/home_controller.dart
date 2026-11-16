import '../models/categoria.dart';
import '../models/dados_locais.dart';

class HomeController {
  List<Categoria> get categorias => categoriasCadastradas;

  String subtitulo(Categoria categoria) {
    if (!categoria.mostrarQuantidade) return 'Estabelecimentos próximos';
    return '${categoria.locais.length} estabelecimentos';
  }
}
