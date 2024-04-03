import 'package:test_drive/models/exercise.dart'; // Ensure this path is correct

class Workout {
  String name;
  List<Exercise> exercises;
  String? key;

  Workout({
    required this.name,
    required this.exercises,
    this.key,
  });

  factory Workout.fromMap(Map<String, dynamic> map, {String? key}) {
    var exercisesList = map['exercises'] as List<dynamic>? ?? [];
    List<Exercise> exercises = exercisesList.map((e) => Exercise.fromMap(Map<String, dynamic>.from(e))).toList();
    return Workout(
      name: map['name'] ?? '',
      exercises: exercises,
      key: key,
    );
  }
}
