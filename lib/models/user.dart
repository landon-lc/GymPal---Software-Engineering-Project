import '../models/friend.dart';
import '../models/workout.dart';
import '../models/workout_record.dart';
import '../models/exercise.dart';
import '../models/profile.dart';

class User extends Profile {
  
  // Dynamic sets for user data.  
  var friendsList = <Friend>{};
  var workoutTemplates = <Workout>{};
  var workouts = <WorkoutRecord>{};
  var exercises = <Exercise>{};

}