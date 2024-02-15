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
}