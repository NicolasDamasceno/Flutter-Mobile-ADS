import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Compras',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const HomePage(),
    );
  }
}

class Item {
  Item({required this.nome, required this.chek});

  String nome;
  bool chek;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Item> items = [
    Item(nome: 'Arroz', chek: true),
    Item(nome: 'Feijao', chek: true),
    Item(nome: 'Farinha', chek: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Center(child: Text('OP')),
        title: const Text('Home'),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.local_grocery_store),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];
          return CheckboxListTile(
            key: Key(item.nome),
            title: Text(item.nome),
            value: item.chek,
            // Ao pressionar, inverte o checkbox e reconstrói a tela
            onChanged: (bool? value) {
              setState(() {
                item.chek = value ?? false;
              });
            },
          );
        },
      ),
    );
  }
}
