class Friend {
  // this will late select certain attributes from the profile class
  String? userName;
  String? password;
  String? email;
  // find a way to add a profile picture
  String? aboutMe;
  // list of gyms here

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
}