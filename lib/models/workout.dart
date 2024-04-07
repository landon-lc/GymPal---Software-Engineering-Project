import 'package:test_drive/models/exercise.dart';

class Workout {
  String name;
  List<Exercise> exercises;
  String? key;

  Workout({required this.name, required this.exercises, this.key});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'exercises': exercises.map((e) => e.toMap()).toList(),
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map, {String? key}) {
    var exercisesData = map['exercises'];
    List<Exercise> exercises;
    if (exercisesData is List<dynamic>) {
      exercises = exercisesData.map((e) => Exercise.fromMap(e as Map<String, dynamic>)).toList();
    } else {
      exercises = [];
    }

    return Workout(
      name: map['name'] as String? ?? '',
      exercises: exercises,
      key: key,
    );
  }
}
