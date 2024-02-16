import 'models/Friend.dart';
// File Strictly for learning how to use dart

void main() {
  Friend f = Friend();
  f.setUserName('RandomName');
  f.setAboutMe('A Person Looking For Gym Friends!');
  f.setEmail('RandomEmail@gmail.com');
  f.setPassword('RandomPassword');
  print(f.getAboutMe() + f.getEmail() + f.getUserName() + f.getPassword());
}