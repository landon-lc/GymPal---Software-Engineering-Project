import '../models/Friend.dart';
// File Strictly for learning how to use dart

void main() {
  Friend f = Friend();
  f.setUserName('RandomName');
  f.setAboutMe('A Person Looking For Gym Friends!');
  f.setEmail('RandomEmail@gmail.com');
  f.setPassword('RandomPassword');
  print(f.getAboutMe() + '\n' + f.getEmail() + '\n' + f.getUserName() +  '\n' + f.getPassword()); // use interpolation to compose strings?
}