import '../models/gym.dart';

class Profile {
  String username;
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