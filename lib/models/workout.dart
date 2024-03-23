import 'package:test_drive/models/exercise.dart';

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
    List<Exercise> exercises = [];
    if (map['exercises'] != null) {
      exercises = (map['exercises'] as List).map((exerciseMap) {
        return Exercise.fromMap(Map<String, dynamic>.from(exerciseMap));
      }).toList();
    }
    return Workout(
      name: map['name'] ?? '',
      exercises: exercises,
      key: key,
    );
  }
}
