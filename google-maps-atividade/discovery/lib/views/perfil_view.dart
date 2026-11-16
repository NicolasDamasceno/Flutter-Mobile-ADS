import 'package:flutter/material.dart';

import '../controllers/perfil_controller.dart';
import '../controllers/salvos_controller.dart';

class PerfilView extends StatelessWidget {
  const PerfilView({super.key, required this.controller, required this.salvos});

  final PerfilController controller;
  final SalvosController salvos;

  @override
  Widget build(BuildContext context) {
    final perfil = controller.perfil;
    final cores = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: cores.inversePrimary,
        title: const Text('Perfil'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          CircleAvatar(
            radius: 48,
            backgroundColor: cores.primaryContainer,
            child: Icon(Icons.person, size: 56, color: cores.primary),
          ),
          const SizedBox(height: 16),
          Text(
            perfil.nome,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('E-mail'),
            subtitle: Text(perfil.email),
          ),
          ListTile(
            leading: const Icon(Icons.location_city),
            title: const Text('Cidade'),
            subtitle: Text(perfil.cidade),
          ),
          ListenableBuilder(
            listenable: salvos,
            builder: (context, _) => ListTile(
              leading: const Icon(Icons.bookmark),
              title: const Text('Locais salvos'),
              subtitle: Text('${salvos.salvos.length}'),
            ),
          ),
        ],
      ),
    );
  }
}
