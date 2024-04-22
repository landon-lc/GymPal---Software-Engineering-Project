import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' as gmaps;  // Aliased import
import 'package:location/location.dart' as loc;

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
  loc.Location _locationService = loc.Location();
  loc.LocationData? _currentLocation;
  gmaps.GoogleMapsPlaces _places = gmaps.GoogleMapsPlaces(apiKey: 'AIzaSyCTIZuY972s7eTxV1S0TcMz82mgi-Wa2J0'); // Use your actual API key

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    bool serviceEnabled = await _locationService.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationService.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    loc.PermissionStatus permissionGranted = await _locationService.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await _locationService.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final loc.LocationData locationData = await _locationService.getLocation();
      setState(() {
        _currentLocation = locationData;
        _updateCameraPosition();
      });
    } catch (e) {
      print('Could not get location: $e');
    }
  }

  void _updateCameraPosition() {
    if (_mapController != null && _currentLocation != null) {
      _mapController!.moveCamera(
        CameraUpdate.newLatLng(
          LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!)
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
      gmaps.Location(lat: _currentLocation!.latitude!, lng: _currentLocation!.longitude!),
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
              position: LatLng(result.geometry?.location.lat ?? 0.0, result.geometry?.location.lng ?? 0.0),
              infoWindow: InfoWindow(title: result.name),
              onTap: () => _onMarkerTapped(result.name, result.placeId),
            ),
          );
        }
      });
    } else {
      print('Failed to find gyms: ${response.errorMessage}');
    }
  }

  void _onMarkerTapped(String gymName, String placeId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Favorite Gym'),
          content: Text('Do you want to save "$gymName" as your favorite Gym?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                _selectGym(placeId);
              },
            ),
          ],
        );
      },
    );
  }

  void _selectGym(String placeId) {
    // Can code actions after selecting gym here.
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
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
                _updateCameraPosition();
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(_currentLocation?.latitude ?? 0.0, _currentLocation?.longitude ?? 0.0),
                zoom: 11,
              ),
              markers: _markers,
            ),
    );
  }
}
