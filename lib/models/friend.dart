import 'profile.dart'; // Use for the class variables
import 'gym.dart';

class Friend {
  // this will later select certain attributes from the profile class
  String? userName; // may need to make this non nullable
  String? password;
  String? email;
  // find a way to add a profile picture
  String? aboutMe;
  // list of gyms here
   List<String> gym = []; // this is temporarily going to be a String

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
    userName = name;
  }

  void setPassword(String p) {
    password = p;
  }

  void setEmail(String e) {
    email = e;
  }

  void setAboutMe(String a) {
    aboutMe = a;
  }

  //random methods (These aren't working currently)

  void addGym(String g) {
    this.gym.add(g);
  }

  void displayGyms() {
    for (String g in this.gym) {
      print(g);
    }
  }
}