import 'workout.dart';
import 'workout_record.dart';
import 'exercise.dart';
import 'profile.dart';

class User extends Profile {
  // Dynamic lists for user attributes - lists can be empty.
  List<Workout?> workoutTemplates;
  List<WorkoutRecord?> workouts;
  List<Exercise?> exercises;

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
