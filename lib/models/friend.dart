class Friend {
  // this will later select certain attributes from the profile class
  String? userName;
  String? password;
  String? email;
  // find a way to add a profile picture
  String? aboutMe;
  // list of gyms here
  var gyms = []; // make this settable

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

  void addGym(String g) {
    gyms.add(g);
  }

  void displayGyms() {
    for (String g in gyms) {
      print(g);
    }
  }
}