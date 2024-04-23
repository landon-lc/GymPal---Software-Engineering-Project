class Gym {
  final String name;
  final double latitude;
  final double longitude;

  // Constructor
  Gym({required this.name, required this.latitude, required this.longitude});

  //class specific methods
  String displayName() {
    // temp method for just displaying methods right now
    return name;
  }
}

var gyms = [
  Gym(name: 'Golds Gym', latitude: 34.25, longitude: -77.90),
  Gym(name: 'Planet Fitness', latitude: 34.27, longitude: -77.95)
];

// map_screen will be used for setting up the map intergration.