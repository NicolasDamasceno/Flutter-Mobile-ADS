import 'package:flutter/material.dart';

import '../controllers/home_controller.dart';
import '../controllers/perfil_controller.dart';
import '../controllers/salvos_controller.dart';
import '../models/categoria.dart';
import 'home_view.dart';
import 'mapa_view.dart';
import 'perfil_view.dart';
import 'salvos_view.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final HomeController _homeController = HomeController();
  final PerfilController _perfilController = PerfilController();
  final SalvosController _salvosController = SalvosController();

  static const int _abaHome = 0;
  static const int _abaSalvos = 1;

  int _abaAtual = _abaHome;

  Categoria? _categoriaAberta;

  @override
  void dispose() {
    _salvosController.dispose();
    super.dispose();
  }

  void _selecionarAba(int aba) {
    setState(() {
      _abaAtual = aba;
      if (aba == _abaHome) _categoriaAberta = null;
    });
  }

  void _abrirCategoria(Categoria categoria) {
    setState(() => _categoriaAberta = categoria);
  }

  void _fecharMapa() {
    setState(() => _categoriaAberta = null);
  }

  Widget _conteudo() {
    switch (_abaAtual) {
      case _abaHome:
        final categoria = _categoriaAberta;
        if (categoria == null) {
          return HomeView(
            controller: _homeController,
            onAbrirCategoria: _abrirCategoria,
          );
        }
        return MapaView(
          categoria: categoria,
          salvos: _salvosController,
          onVoltar: _fecharMapa,
        );
      case _abaSalvos:
        return SalvosView(salvos: _salvosController);
      default:
        return PerfilView(
          controller: _perfilController,
          salvos: _salvosController,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final naTelaDeCards = _abaAtual == _abaHome && _categoriaAberta == null;

    return PopScope(
      canPop: naTelaDeCards,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _selecionarAba(_abaHome);
      },
      child: Scaffold(
        body: _conteudo(),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _abaAtual,
          onDestinationSelected: _selecionarAba,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.bookmark), label: 'Salvos'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Perfil'),
          ],
        ),
      ),
    );
  }
}
