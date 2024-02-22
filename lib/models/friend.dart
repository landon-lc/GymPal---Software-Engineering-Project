import 'profile.dart'; // Use for the class variables
import 'gym.dart';

class Friend {
  // this will later select certain attributes from the profile class
  String? userName; 
  String? password; // This will be changed to reference methods in the profile class
  String? email;
  // future spot for profile picture
  String? aboutMe;
  List<Gym> gym = []; // this is temporarily going to be a String

  Friend({
    required this.userName,
    required this.password,
    required this.email,
    required this.aboutMe
  });

  // getters

  String getUserName() {
    return this.userName!;
  }

  String getPassword() {
    return this.password!;
  }

  String getEmail() {
    return this.email!;
  }

  String getAboutMe() {
    return this.aboutMe!;
  }

  // setters

  void setUserName(String name) {
    this.userName = name;
  }

  void setPassword(String p) {
    this.password = p;
  }

  void setEmail(String e) {
    this.email = e;
  }

  void setAboutMe(String a) {
    this.aboutMe = a;
  }

  //random methods (These aren't working currently)

  void addGym(Gym g) {
    this.gym.add(g);
  }

  void displayGyms() {
    for (Gym g in this.gym) {
      print(g);
    }
  }
}