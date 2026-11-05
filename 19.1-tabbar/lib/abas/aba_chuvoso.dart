import 'package:flutter/material.dart';

import 'conteudo_clima.dart';

class AbaChuvoso extends StatelessWidget {
  const AbaChuvoso({super.key});

  @override
  Widget build(BuildContext context) {
    return const ConteudoClima(
      icone: Icons.beach_access_sharp,
      cor: Colors.indigo,
      titulo: 'Está chovendo aqui',
      temperatura: '19 °C',
      descricao: 'Chuva moderada à tarde, com rajadas de vento.',
      dicas: [
        'Não esqueça o guarda-chuva',
        'Dirija com cuidado',
        'Evite áreas com risco de alagamento',
      ],
    );
  }
}
