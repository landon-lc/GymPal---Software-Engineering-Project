import '../lib/models/friend.dart';
import '../lib/models/gym.dart';
// File Strictly for learning how to use dart

void main() {
  Friend f = Friend(userName:'RandomName', aboutMe: 'A Person Looking For Gym Friends!', email: 'RandomEmail@gmail.com', password: 'RandomPassword');
  print(f.getAboutMe() + '\n' + f.getEmail() + '\n' + f.getUserName() +  '\n' + f.getPassword()); // use interpolation to compose strings?
}