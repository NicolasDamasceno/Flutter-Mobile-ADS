import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Maps',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Google Maps'),
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
  late GoogleMapController mapController;
  Set<Marker> _markers = {};
  // Só liga o ponto azul depois que a permissão de localização for concedida
  bool _localizacaoPermitida = false;

  static const LatLng _ponteEstaiada = LatLng(-5.0701855, -42.8029442);

  /// Transforma uma imagem de assets/imagens em um ícone redondo, com borda
  /// branca, para usar no lugar do alfinete vermelho padrão do marcador.
  Future<BitmapDescriptor> _iconeComFoto(String caminho) async {
    const int tamanho = 200; // em pixels
    const double raio = tamanho / 2;
    const double borda = 8;

    // Carrega a foto já reduzida, para não pesar na memória
    final ByteData dados = await rootBundle.load(caminho);
    final ui.Codec codec = await ui.instantiateImageCodec(
      dados.buffer.asUint8List(),
      targetHeight: tamanho,
    );
    final ui.Image foto = (await codec.getNextFrame()).image;

    final ui.PictureRecorder gravador = ui.PictureRecorder();
    final Canvas canvas = Canvas(gravador);

    // Círculo branco que forma a borda
    canvas.drawCircle(
      const Offset(raio, raio),
      raio,
      Paint()..color = Colors.white,
    );

    // Recorta o centro da foto em formato de círculo
    canvas.clipPath(Path()
      ..addOval(Rect.fromCircle(
        center: const Offset(raio, raio),
        radius: raio - borda,
      )));
    final double lado =
        (foto.width < foto.height ? foto.width : foto.height).toDouble();
    canvas.drawImageRect(
      foto,
      Rect.fromLTWH(
          (foto.width - lado) / 2, (foto.height - lado) / 2, lado, lado),
      const Rect.fromLTWH(0, 0, tamanho * 1.0, tamanho * 1.0),
      Paint()..filterQuality = FilterQuality.high,
    );

    final ui.Image icone =
        await gravador.endRecording().toImage(tamanho, tamanho);
    final ByteData? png =
        await icone.toByteData(format: ui.ImageByteFormat.png);
    // width = tamanho do ícone no mapa
    return BitmapDescriptor.bytes(png!.buffer.asUint8List(), width: 64);
  }

  Future<void> _carregarMarcadores() async {
    final BitmapDescriptor iconePonte =
        await _iconeComFoto('assets/imagens/ponte-estaiada.jpg');
    final BitmapDescriptor iconeIfpi =
        await _iconeComFoto('assets/imagens/ifpi-central.jpeg');
    final BitmapDescriptor iconeIfpiSul =
        await _iconeComFoto('assets/imagens/ifpi-sul.png');

    Set<Marker> marcadoresLocal = {};
    Marker marcadorPonteEstaiada = Marker(
      markerId: const MarkerId('Ponte Estaiada'),
      position: _ponteEstaiada,
      icon: iconePonte,
      infoWindow:
          const InfoWindow(title: 'Ponte Estaiada', snippet: 'Teresina - PI'),
    );
    Marker marcadorIfpi = Marker(
      markerId: const MarkerId('IFPI'),
      position: const LatLng(-5.088544046019581, -42.81123803149089),
      icon: iconeIfpi,
      infoWindow: const InfoWindow(title: 'IFPI'),
    );
    Marker marcadorIfpiSul = Marker(
      markerId: const MarkerId('IFPI Sul'),
      position: const LatLng(-5.101723, -42.813114),
      icon: iconeIfpiSul,
      infoWindow: const InfoWindow(title: 'IFPI Sul'),
    );
    marcadoresLocal.add(marcadorPonteEstaiada);
    marcadoresLocal.add(marcadorIfpi);
    marcadoresLocal.add(marcadorIfpiSul);

    // A tela pode ter sido fechada enquanto as imagens carregavam
    if (!mounted) return;
    setState(() {
      _markers = marcadoresLocal;
    });
  }

  _localizacaoAtual() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
      print('Localização atual: ${position.latitude}, ${position.longitude}');
  }
  Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
  }
  

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    // Pede a permissão e move a câmera até a posição atual do celular
    try {
      Position posicao = await _determinePosition();
      setState(() {
        _localizacaoPermitida = true;
      });
      mapController.animateCamera(
        CameraUpdate.newLatLng(LatLng(posicao.latitude, posicao.longitude)),
      );
    } catch (erro) {
      print(erro); // GPS desligado ou permissão negada
    }
  }

  @override
  void initState(){
    super.initState();
    _carregarMarcadores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: GoogleMap(
        myLocationEnabled: _localizacaoPermitida,
        onMapCreated: _onMapCreated,
        markers: _markers,
        initialCameraPosition: const CameraPosition(
          target: _ponteEstaiada,
          zoom: 13,
        ),
      ),
    );
  }
}
