import 'package:flutter/material.dart';

import '../controllers/home_controller.dart';
import '../models/categoria.dart';
import 'components/categoria_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
    required this.controller,
    required this.onAbrirCategoria,
  });

  final HomeController controller;
  final ValueChanged<Categoria> onAbrirCategoria;

  @override
  Widget build(BuildContext context) {
    final categorias = controller.categorias;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Discovery'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          mainAxisExtent: 190,
        ),
        itemCount: categorias.length,
        itemBuilder: (context, indice) {
          final categoria = categorias[indice];
          return CategoriaCard(
            icone: categoria.icone,
            nome: categoria.nome,
            subtitulo: controller.subtitulo(categoria),
            onTap: () => onAbrirCategoria(categoria),
          );
        },
      ),
    );
  }
}
