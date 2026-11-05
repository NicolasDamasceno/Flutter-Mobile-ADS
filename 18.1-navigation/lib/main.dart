import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Navigation Basics',
      debugShowCheckedModeBanner: false,
      // c) Navegação por rotas nomeadas: '/' é a página raiz
      initialRoute: PrimeiraPagina.rota,
      routes: {
        PrimeiraPagina.rota: (context) => const PrimeiraPagina(),
        SegundaPagina.rota: (context) => const SegundaPagina(),
      },
    ),
  );
}

class PrimeiraPagina extends StatelessWidget {
  const PrimeiraPagina({super.key});

  static const String rota = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // b) Título da página atual no AppBar
      appBar: AppBar(title: const Text('Primeira Página')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // a) Navegação com push() criando a rota na hora
            ElevatedButton(
              child: const Text('Abrir com push()'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SegundaPagina()),
                );
              },
            ),
            const SizedBox(height: 16),
            // c) Navegação usando a rota nomeada
            ElevatedButton(
              child: const Text('Abrir com rota nomeada'),
              onPressed: () {
                Navigator.pushNamed(context, SegundaPagina.rota);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SegundaPagina extends StatelessWidget {
  const SegundaPagina({super.key});

  static const String rota = '/segunda';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // b) Título da página atual no AppBar
      appBar: AppBar(title: const Text('Segunda Página')),
      body: Center(
        // a) Volta para a página anterior com pop()
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Voltar'),
        ),
      ),
    );
  }
}
