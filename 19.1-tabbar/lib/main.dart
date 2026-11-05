import 'package:flutter/material.dart';

import 'abas/aba_chuvoso.dart';
import 'abas/aba_ensolarado.dart';
import 'abas/aba_nublado.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TabBar Widget',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// [AnimationController]s podem ser criados com `vsync: this` por causa do
/// [TickerProviderStateMixin].
class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TabBar Widget'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(icon: Icon(Icons.cloud_outlined), text: 'Nublado'),
            Tab(icon: Icon(Icons.beach_access_sharp), text: 'Chuvoso'),
            Tab(icon: Icon(Icons.brightness_5_sharp), text: 'Ensolarado'),
          ],
        ),
      ),
      // Cada aba é uma classe externa, em lib/abas/
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          AbaNublado(),
          AbaChuvoso(),
          AbaEnsolarado(),
        ],
      ),
    );
  }
}
