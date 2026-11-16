import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/salvos_controller.dart';
import '../models/categoria.dart';
import '../models/local.dart';

class MapaView extends StatelessWidget {
  const MapaView({
    super.key,
    required this.categoria,
    required this.salvos,
    required this.onVoltar,
  });

  final Categoria categoria;
  final SalvosController salvos;
  final VoidCallback onVoltar;

  LatLngBounds get _limites {
    final latitudes = categoria.locais.map((l) => l.posicao.latitude);
    final longitudes = categoria.locais.map((l) => l.posicao.longitude);
    return LatLngBounds(
      southwest: LatLng(latitudes.reduce(min), longitudes.reduce(min)),
      northeast: LatLng(latitudes.reduce(max), longitudes.reduce(max)),
    );
  }

  Set<Marker> _marcadores(BuildContext context) {
    return {
      for (final local in categoria.locais)
        Marker(
          markerId: MarkerId(local.id),
          position: local.posicao,
          icon: salvos.estaSalvo(local)
              ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)
              : BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: local.nome, snippet: local.descricao),
          onTap: () => _mostrarDetalhes(context, local),
        ),
    };
  }

  void _mostrarDetalhes(BuildContext context, Local local) {
    showModalBottomSheet<void>(
      context: context,
      builder: (contextoSheet) {
        final salvo = salvos.estaSalvo(local);
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                local.nome,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(local.descricao),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.place, size: 18),
                  const SizedBox(width: 4),
                  Expanded(child: Text(local.endereco)),
                ],
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                icon: Icon(salvo ? Icons.bookmark_remove : Icons.bookmark_add),
                label: Text(salvo ? 'Remover dos salvos' : 'Salvar'),
                onPressed: () {
                  salvos.alternar(local);
                  Navigator.pop(contextoSheet);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(salvo
                          ? '${local.nome} removido dos salvos'
                          : '${local.nome} adicionado aos salvos'),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: BackButton(onPressed: onVoltar),
        title: Text(categoria.nome),
      ),
      body: ListenableBuilder(
        listenable: salvos,
        builder: (context, _) => GoogleMap(
          markers: _marcadores(context),
          initialCameraPosition: CameraPosition(
            target: LatLng(
              (_limites.southwest.latitude + _limites.northeast.latitude) / 2,
              (_limites.southwest.longitude + _limites.northeast.longitude) / 2,
            ),
            zoom: 13,
          ),
          onMapCreated: (controller) => controller
              .animateCamera(CameraUpdate.newLatLngBounds(_limites, 80)),
        ),
      ),
    );
  }
}
