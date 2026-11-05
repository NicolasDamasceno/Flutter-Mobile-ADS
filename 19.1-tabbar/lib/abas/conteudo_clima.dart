import 'package:flutter/material.dart';

/// Layout comum das abas: ícone, título, temperatura, descrição e dicas.
class ConteudoClima extends StatelessWidget {
  const ConteudoClima({
    super.key,
    required this.icone,
    required this.cor,
    required this.titulo,
    required this.temperatura,
    required this.descricao,
    required this.dicas,
  });

  final IconData icone;
  final Color cor;
  final String titulo;
  final String temperatura;
  final String descricao;
  final List<String> dicas;

  @override
  Widget build(BuildContext context) {
    final textos = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: cor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(icone, size: 96, color: cor),
              const SizedBox(height: 8),
              Text(titulo, style: textos.headlineSmall),
              Text(temperatura, style: textos.displaySmall),
              const SizedBox(height: 8),
              Text(descricao, textAlign: TextAlign.center),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text('Dicas para hoje', style: textos.titleMedium),
        for (final dica in dicas)
          ListTile(
            leading: Icon(Icons.check_circle_outline, color: cor),
            title: Text(dica),
          ),
      ],
    );
  }
}
