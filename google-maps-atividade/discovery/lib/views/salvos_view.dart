import 'package:flutter/material.dart';

import '../controllers/salvos_controller.dart';

class SalvosView extends StatelessWidget {
  const SalvosView({super.key, required this.salvos});

  final SalvosController salvos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Salvos'),
      ),
      body: ListenableBuilder(
        listenable: salvos,
        builder: (context, _) {
          final locais = salvos.salvos;
          if (locais.isEmpty) {
            return const Center(
              child: Text('Nenhum local salvo.\nToque em um marcador no mapa para salvar.',
                  textAlign: TextAlign.center),
            );
          }
          return ListView.separated(
            itemCount: locais.length,
            separatorBuilder: (context, indice) => const Divider(height: 1),
            itemBuilder: (context, indice) {
              final local = locais[indice];
              return ListTile(
                title: Text(local.nome),
                subtitle: Text(local.endereco),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: 'Excluir dos salvos',
                  onPressed: () {
                    salvos.remover(local);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${local.nome} removido dos salvos')),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
