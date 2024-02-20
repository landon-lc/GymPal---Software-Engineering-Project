import '../models/gym.dart';

class Profile {
  String username;
  // In reality, credential management will be handled by Firebase Authentication.
  String password;
  String email;
  String bio;
  // Using NULL safety through the '?' operator.
  // Ensure this is handled appropriately.
  Gym? gym;

  Profile({
    // The following are required parameters for a profile to exist.
    required this.username,
    required this.password,
    required this.email,
    required this.bio,
    // The user may not necessarily have a gym, so it is optional.
    this.gym,
    });
}

// No gym objects atm, so they aren't included.
var testProfiles = [
  Profile(bio: 'Hey', email: 'sudo@root.com', password: 'password', username: 'admin'),
  Profile(bio: 'What\'s up?', email: 'ryansanchez@gmail.com', password: 'password', username: 'ryansanchez'),
];