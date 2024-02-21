import '../models/friend.dart';
import '../models/workout.dart';
import '../models/workout_record.dart';
import '../models/exercise.dart';
import '../models/profile.dart';

class User extends Profile {
  
  // Dynamic lists for user attributes - lists can be empty.  
  List<Friend?>friendsList;
  List<Workout?>workoutTemplates;
  List<WorkoutRecord?>workouts;
  List<Exercise?>exercises;

  User({

    // User constructors - required. 
    required this.friendsList,
    required this.workoutTemplates,
    required this.workouts, 
    required this.exercises,

    // Extending the required superclass constructors. 
    required super.username,
    required super.password,
    required super.email,
    required super.bio,

    // Gym is optional.
    super.gym,

  });

}

var userSampleData = [
  User(friendsList: [], workoutTemplates: [sampleWorkouts[0]], workouts: [sampleRecords[0]], exercises: [sampleExercises[1]], username: 'johnDoe123', password: 'johnPass1357', email: 'john@gmail.com', bio: 'Welcome to my page!')
];