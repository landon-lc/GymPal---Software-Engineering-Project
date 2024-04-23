import 'gym.dart';

class Friend {
  // maybe think about using inheritance from profile?
  // this will later select certain attributes from the profile class
  String? userName;
  String?
      password; // This will be changed to reference methods in the profile class
  String? email;
  // future spot for profile picture
  String? aboutMe;
  List<Gym> gym = []; // this is temporarily going to be a String

  Friend(
      {required this.userName,
      required this.password,
      required this.email,
      required this.aboutMe});

  // getters

  String getUserName() {
    return userName!;
  }

  String getPassword() {
    return password!;
  }

  String getEmail() {
    return email!;
  }

  String getAboutMe() {
    return aboutMe!;
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

  void addGym(Gym g) {
    gym.add(g);
  }

  void displayGyms() {
    for (Gym g in gym) {
      print(g
          .displayName()); // change this in future to show location and name, not just name
    }
  }
}