import 'package:flutter/material.dart';

import 'conteudo_clima.dart';

class AbaNublado extends StatelessWidget {
  const AbaNublado({super.key});

  @override
  Widget build(BuildContext context) {
    return const ConteudoClima(
      icone: Icons.cloud_outlined,
      cor: Colors.blueGrey,
      titulo: 'Está nublado aqui',
      temperatura: '24 °C',
      descricao: 'Céu encoberto durante o dia, sem previsão de chuva.',
      dicas: [
        'Leve um casaco leve',
        'Bom dia para caminhar',
        'Use protetor solar mesmo com nuvens',
      ],
    );
  }
}
