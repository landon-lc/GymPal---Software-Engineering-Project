import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:location/location.dart' as loc;

void main() {
  runApp(const GymMapApp());
}

class GymMapApp extends StatelessWidget {
  const GymMapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Gym Finder',
      home: GymMaps(),
    );
  }
}

class GymMaps extends StatefulWidget {
  const GymMaps({super.key});

  @override
  State<GymMaps> createState() => _GymMapsState();
}

class _GymMapsState extends State<GymMaps> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  final TextEditingController _searchController = TextEditingController();
  final loc.Location _locationService = loc.Location();
  loc.LocationData? _currentLocation;
  final _places =
      GoogleMapsPlaces(apiKey: 'AIzaSyCTIZuY972s7eTxV1S0TcMz82mgi-Wa2J0');

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    final serviceEnabled = await _locationService.serviceEnabled();
    if (!serviceEnabled) {
      await _locationService.requestService();
    }

    var permissionGranted = await _locationService.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await _locationService.requestPermission();
    }

    if (permissionGranted == loc.PermissionStatus.granted) {
      _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    final locationData = await _locationService.getLocation();
    setState(() {
      _currentLocation = locationData;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    if (_currentLocation != null) {
      _mapController!.moveCamera(
        CameraUpdate.newLatLng(
          LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
        ),
      );
    }
  }

  Future<void> _searchGyms(String query) async {
    if (_currentLocation == null) {
      print('Current location is not available.');
      return;
    }

    final response = await _places.searchNearbyWithRadius(
      Location(
          lat: _currentLocation!.latitude!, lng: _currentLocation!.longitude!),
      10000,
      keyword: query,
      type: 'gym',
    );

    if (response.status == 'OK') {
      setState(() {
        _markers.clear();
        for (final result in response.results) {
          _markers.add(
            Marker(
              markerId: MarkerId(result.placeId),
              position: LatLng(result.geometry?.location.lat ?? 0.0,
                  result.geometry?.location.lng ?? 0.0),
              infoWindow: InfoWindow(title: result.name),
            ),
          );
        }
      });
    } else {
      print('Failed to find gyms: ${response.errorMessage}');
    }
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
              icon: const Icon(Icons.search),
              onPressed: () => _searchGyms(_searchController.text),
            ),
          ),
          onSubmitted: (value) => _searchGyms(value),
        ),
      ),
      body: _currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    _currentLocation!.latitude!, _currentLocation!.longitude!),
                zoom: 11,
              ),
              markers: _markers,
            ),
    );
  }
}
