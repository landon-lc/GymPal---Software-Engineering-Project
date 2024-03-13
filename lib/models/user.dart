import '../models/friend.dart'; // probably dont need this import statemnet, profile already has a friends list and user inherits this
import '../models/workout.dart';
import '../models/workout_record.dart';
import '../models/exercise.dart';
import '../models/profile.dart';

class User extends Profile { 
  
  // Dynamic lists for user attributes - lists can be empty.  
  List<Workout?>workoutTemplates;
  List<WorkoutRecord?>workouts;
  List<Exercise?>exercises;

  User({

    // User constructors - required. 
    required this.workoutTemplates,
    required this.workouts, 
    required this.exercises,

    // Extending the required superclass constructors. 
    required super.username,
    required super.password,
    required super.email,
    required super.bio,
  });

}

var userSampleData = [
  User(workoutTemplates: [sampleWorkouts[0]], workouts: [sampleRecords[0]], exercises: [sampleExercises[1]], username: 'johnDoe123', password: 'johnPass1357', email: 'john@gmail.com', bio: 'Welcome to my page!')
];