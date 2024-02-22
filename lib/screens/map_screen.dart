import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/gym.dart';

class MapScreen extends StatefulWidget {
  final List<Gym> gyms;

  const MapScreen({Key? key, required this.gyms}) : super(key: key);

  @override
  MapScreenState createState() => MapScreenState();
  
 }

class MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _createMarkers();
  }

  void _createMarkers() {
    _markers.clear();
    for (final gym in widget.gyms) {
      _markers.add(
        Marker(
          markerId: MarkerId(gym.name),
          position: LatLng(gym.latitude, gym.longitude),
          infoWindow: InfoWindow(title: gym.name),
        ),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Gyms'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.gyms.first.latitude, widget.gyms.first.longitude),
          zoom: 14.0,
        ),
        markers: _markers,
      ),
    );
  }
}