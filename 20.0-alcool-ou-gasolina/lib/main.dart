import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Álcool ou Gasolina',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Álcool ou Gasolina'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textEditeControllerGasolina =
      TextEditingController();
  final TextEditingController _textEditeControllerAlcool =
      TextEditingController();

  static const String _imagemPadrao =
      'https://media.istockphoto.com/vectors/stream-of-gold-coins-pours-from-the-fuel-handle-pump-nozzle-with-hose-vector-id1251678227?k=20&m=1251678227&s=612x612&w=0&h=WueKOjZwKgOk0wRBcj9zhL7Bli9N4Vy3vs8NcDJHwBA=';
  static const String _imagemGasolina =
      'https://quatrorodas.abril.com.br/wp-content/uploads/2025/07/GASOLINA.jpeg.jpg?crop=1&resize=1212,909';
  static const String _imagemAlcool =
      'https://blog.sensix.ag/wp-content/uploads/2021/10/image-20.jpeg';

  double resultado = 0.0;
  String _mensagem = '';
  String _imagemUrl = _imagemPadrao;

  void _calcular() {
    // Aceita "5,49" (vírgula) além de "5.49"
    double gasolina = double.tryParse(
          _textEditeControllerGasolina.text.replaceAll(',', '.'),
        ) ??
        0;
    double alcool = double.tryParse(
          _textEditeControllerAlcool.text.replaceAll(',', '.'),
        ) ??
        0;

    setState(() {
      if (gasolina <= 0 || alcool <= 0) {
        resultado = 0.0;
        _mensagem = 'Informe valores válidos para os dois combustíveis';
        _imagemUrl = _imagemPadrao;
        return;
      }

      resultado = alcool / gasolina * 100;

      // Regra usada aqui (o slide da aula diz o contrário: ">= 70, álcool"):
      // o álcool rende cerca de 70% da gasolina, ou seja, o carro roda menos
      // km com 1 litro de álcool. Por isso o álcool só compensa quando custa
      // MENOS de 70% do preço da gasolina.
      //   resultado = preço do álcool / preço da gasolina * 100
      //   resultado <  70 -> abastecer com álcool
      //   resultado >= 70 -> abastecer com gasolina
      // Exemplos: gasolina R$ 6,00 e álcool R$ 4,00 -> 66,7% -> álcool
      //           gasolina R$ 6,00 e álcool R$ 4,50 -> 75,0% -> gasolina
      if (resultado < 70) {
        _mensagem = 'Abastecer com Álcool';
        _imagemUrl = _imagemAlcool;
      } else {
        _mensagem = 'Abastecer com Gasolina';
        _imagemUrl = _imagemGasolina;
      }
    });
  }

  @override
  void dispose() {
    _textEditeControllerGasolina.dispose();
    _textEditeControllerAlcool.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Melhor Combustível',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Image.network(
              _imagemUrl,
              height: 200,
              fit: BoxFit.contain,
              webHtmlElementStrategy: WebHtmlElementStrategy.fallback,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.local_gas_station, size: 120),
            ),
            const SizedBox(height: 24),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                label: Text('Valor do etanol'),
                prefixText: 'R\$ ',
                border: OutlineInputBorder(),
              ),
              controller: _textEditeControllerAlcool,
            ),
            const SizedBox(height: 16),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                label: Text('Valor da gasolina'),
                prefixText: 'R\$ ',
                border: OutlineInputBorder(),
              ),
              controller: _textEditeControllerGasolina,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calcular,
              child: const Text('Calcular'),
            ),
            const SizedBox(height: 24),
            Text(
              _mensagem,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            if (resultado > 0)
              Text(
                'O etanol custa ${resultado.toStringAsFixed(1)}% do preço da gasolina',
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
