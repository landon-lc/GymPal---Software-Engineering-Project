import 'package:test_drive/src/models/exercise.dart';

class Workout {
  String name;
  List<Exercise> exercises;
  String? key;
  DateTime timestamp;

  Workout({required this.name, required this.exercises, this.key, required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'exercises': exercises.map((e) => e.toMap()).toList(),
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map, {String? key}) {
    var exercisesData = map['exercises'];
    List<Exercise> exercises;
    DateTime parsedTimestamp = map['timestamp'] != null ? DateTime.parse(map['timestamp']) : DateTime.now();
    if (exercisesData is List<dynamic>) {
      exercises = exercisesData
          .map((e) => Exercise.fromMap(e as Map<String, dynamic>))
          .toList();
    } else {
      exercises = [];
    }

    return Workout(
      name: map['name'] as String? ?? '',
      exercises: exercises,
      key: key,
      timestamp: parsedTimestamp,
    );
  }
}
