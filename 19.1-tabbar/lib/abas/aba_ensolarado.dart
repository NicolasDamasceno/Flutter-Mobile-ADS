import 'package:flutter/material.dart';

import 'conteudo_clima.dart';

class AbaEnsolarado extends StatelessWidget {
  const AbaEnsolarado({super.key});

  @override
  Widget build(BuildContext context) {
    return const ConteudoClima(
      icone: Icons.brightness_5_sharp,
      cor: Colors.orange,
      titulo: 'Está ensolarado aqui',
      temperatura: '33 °C',
      descricao: 'Céu limpo o dia todo e baixa umidade do ar.',
      dicas: [
        'Beba bastante água',
        'Use protetor solar e boné',
        'Evite o sol entre 10h e 16h',
      ],
    );
  }
}
