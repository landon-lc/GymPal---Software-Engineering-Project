// File made by Brandon Plyler, just for testing classes and their functions
import 'package:test_drive/models/friend.dart';
import 'package:test_drive/models/gym.dart';
// import '../lib/models/user.dart';
// import '../lib/models/exercise.dart';
// import '../lib/models/workout.dart';

// File Strictly for learning how to use dart

void main() {
  Friend f = Friend(
      userName: 'RandomName',
      aboutMe: 'A Person Looking For Gym Friends!',
      email: 'RandomEmail@gmail.com',
      password: 'RandomPassword');
  // print(f.getAboutMe() + '\n' + f.getEmail() + '\n' + f.getUserName() +  '\n' + f.getPassword()); // use interpolation to compose strings?
  Gym gym = Gym(name: 'Golds Gym', latitude: 34.25, longitude: -77.90);
  f.addGym(gym);
  f.displayGyms();
  // User u = User(workoutTemplates: [sampleWorkouts[0]], workouts: [sampleRecords[0]], exercises: [sampleExercises[1]], username: 'johnDoe123', password: 'johnPass1357', email: 'john@gmail.com', bio: 'Welcome to my page!');
  // u.addFriend(f);
  // List<Friend> f_list = u.getFriends();
  // for (var i = 0; i <f_list.length; i++) {
  //   Friend j = f_list[i];
  //   print(j.getUserName());
}
