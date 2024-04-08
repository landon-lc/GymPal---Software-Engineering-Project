import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class GymMaps extends StatefulWidget {
  const GymMaps({super.key});

  @override
  State<GymMaps> createState() => _GymMapsState();
}

class _GymMapsState extends State<GymMaps> {
  static const LatLng _center = LatLng(34.20901806593137, -77.89428829935258);
  final Set<Marker> _markers = {};
  GoogleMapController? _mapController;
  final places = GoogleMapsPlaces(apiKey: 'AIzaSyCTIZuY972s7eTxV1S0TcMz82mgi-Wa2J0');
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_searchController.text.isNotEmpty) {
      _searchGyms(_searchController.text);
    }
  }

  Future<void> _searchGyms(String query) async {
    final result = await places.searchByText(query);
    setState(() {
      _markers.clear();
      if (result.status == "OK") {
        for (var place in result.results) {
          final marker = Marker(
            markerId: MarkerId(place.placeId),
            position: LatLng(
              place.geometry?.location?.lat ?? 0.0, 
              place.geometry?.location?.lng ?? 0.0,
            ),
            infoWindow: InfoWindow(title: place.name),
            onTap: () {
              _mapController?.animateCamera(
                CameraUpdate.newLatLngZoom(
                  LatLng(place.geometry?.location?.lat ?? 0.0, place.geometry?.location?.lng ?? 0.0),
                  11.0, // Zoom level.
                ),
              );
            },
          );
          _markers.add(marker);
        }
        if (result.results.isNotEmpty) {
          _mapController?.animateCamera(
            CameraUpdate.newLatLngZoom(
              LatLng(
                result.results.first.geometry?.location?.lat ?? 0.0,
                result.results.first.geometry?.location?.lng ?? 0.0,
              ),
              11.0, // Zoom level
            ),
          );
        }
      } else {
        print('Search did not yield any results: ${result.errorMessage}');
      }
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search Gyms',
            suffixIcon: IconButton(
              onPressed: _searchController.clear,
              icon: Icon(Icons.clear),
            ),
          ),
          onSubmitted: (value) => _searchGyms(value),
        ),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11,
        ),
        markers: _markers,
      ),
    );
  }
}