import 'package:flutter/material.dart';
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

  void _carregarMarcadores() {
    Set<Marker> marcadoresLocal = {};
    Marker marcadorPonteEstaiada = const Marker(
      markerId: MarkerId('Ponte Estaiada'),
      position: _ponteEstaiada,
      infoWindow: InfoWindow(title: 'Ponte Estaiada', snippet: 'Teresina - PI'),
    );
    Marker marcadorIfpi = const Marker(
      markerId: MarkerId('IFPI'),
      position: LatLng(-5.088544046019581, -42.81123803149089),
      infoWindow: InfoWindow(title: 'IFPI'),
    );
    Marker marcadorIfpiSul = const Marker(
      markerId: MarkerId('IFPI Sul'),
      position: LatLng(-5.101723, -42.813114),
      infoWindow: InfoWindow(title: 'IFPI Sul'),
    );
    marcadoresLocal.add(marcadorPonteEstaiada);
    marcadoresLocal.add(marcadorIfpi);
    marcadoresLocal.add(marcadorIfpiSul);
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
    _carregarMarcadores();
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
