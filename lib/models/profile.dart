import '../models/gym.dart';
import 'friend.dart';

class Profile {
  String username;
  // In reality, credential management will be handled by Firebase Authentication.
  String password;
  String email;
  String bio;
  // Using NULL safety through the '?' operator.
  // Ensure this is handled appropriately.
  List<Gym> gyms = [];
  List<Friend> friends = []; // list of friends that the profile has

  Profile({
    // The following are required parameters for a profile to exist.
    required this.username,
    required this.password,
    required this.email,
    required this.bio,
  });

  // getters
  List<Friend> getFriends() {
    return friends; // may change to return each fiend in the list, but for now just returns the list of friends
  }

  // class specific methods
  void addGym(Gym g) {
    gyms.add(g);
  }

  void addFriend(Friend f) {
    friends.add(f);
  }
}

// No gym objects atm, so they aren't included.
var testProfiles = [
  Profile(
      bio: 'Hey',
      email: 'sudo@root.com',
      password: 'password',
      username: 'admin'),
  Profile(
      bio: 'What\'s up?',
      email: 'ryansanchez@gmail.com',
      password: 'password',
      username: 'ryansanchez'),
];
