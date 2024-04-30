import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' as gmaps;
import 'package:location/location.dart' as loc;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  final gmaps.GoogleMapsPlaces _places =
      gmaps.GoogleMapsPlaces(apiKey: 'AIzaSyCTIZuY972s7eTxV1S0TcMz82mgi-Wa2J0');
  Widget? _infoWidget;
  LatLng? _infoWidgetPosition;

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  Future<void> _requestLocationPermission() async {
    bool serviceEnabled = await _locationService.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationService.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    loc.PermissionStatus permissionGranted =
        await _locationService.hasPermission();
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
      final loc.LocationData locationData =
          await _locationService.getLocation();
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
      _mapController!.moveCamera(CameraUpdate.newLatLng(
          LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!)));
    }
  }

  Future<void> _searchGyms(String query) async {
    if (_currentLocation == null) {
      print('Current location is not available.');
      return;
    }

    final response = await _places.searchNearbyWithRadius(
      gmaps.Location(
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
              position: LatLng(
                  result.geometry!.location.lat, result.geometry!.location.lng),
              onTap: () => _showCustomInfoWindow(
                  result.name,
                  LatLng(result.geometry!.location.lat,
                      result.geometry!.location.lng)),
            ),
          );
        }
      });
    } else {
      print('Failed to find gyms: ${response.errorMessage}');
    }
  }

  void _showCustomInfoWindow(String gymName, LatLng position) {
    setState(() {
      _infoWidgetPosition = position;
      _infoWidget = Card(
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(gymName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              ElevatedButton(
                  onPressed: () => _selectGym(gymName),
                  child: const Text('Favorite this Gym'))
            ],
          ),
        ),
      );
    });
  }

  Future<void> _selectGym(String gymName) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      DatabaseReference userRef =
          FirebaseDatabase.instance.ref('users/${currentUser.uid}');
      await userRef.update({'favGym': gymName});
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Favorite gym is now $gymName.')));
        setState(() {
          _infoWidget = null; // Hide the info window after selection
        });
      }
    } else {
      if (mounted) {
        print('No user is currently signed in.');
      }
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
      body: Stack(
        children: [
          _currentLocation == null
              ? const Center(child: CircularProgressIndicator())
              : GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(_currentLocation?.latitude ?? 0.0,
                        _currentLocation?.longitude ?? 0.0),
                    zoom: 11,
                  ),
                  markers: _markers,
                  myLocationEnabled: true,
                  onTap: (LatLng pos) {
                    setState(() {
                      _infoWidget =
                          null; // Hide the custom info window on map tap
                    });
                  },
                ),
          if (_infoWidget != null && _infoWidgetPosition != null)
            Positioned(
                top: MediaQuery.of(context).padding.top +
                    10, // Positioned at the top
                left: MediaQuery.of(context).size.width / 2 -
                    175, // Centered horizontally
                child: SizedBox(
                  width: 300,
                  child: _infoWidget!,
                ))
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
