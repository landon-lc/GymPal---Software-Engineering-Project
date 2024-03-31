import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GymMaps extends StatefulWidget {
  const GymMaps({super.key});

  @override
  State<GymMaps> createState() => _GymMapsState();
}

class _GymMapsState extends State<GymMaps> {
  static const LatLng _pGooglePlex = LatLng(34.20901806593137, -77.89428829935258);
  // Need another location possibly calling Google Places

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _pGooglePlex,
          zoom: 11,
        ),
        markers: {
          Marker(markerId: MarkerId("_currentlocation"), icon: BitmapDescriptor.defaultMarker,
          position: _pGooglePlex)
        }
      ),
    );
  }
}