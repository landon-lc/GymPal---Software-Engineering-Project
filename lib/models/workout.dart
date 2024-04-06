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

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'exercises': exercises.map((e) => e.toMap()).toList(),
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map, {String? key}) {
    var exercisesMap = (map['exercises'] as Map<String, dynamic>?) ?? {};
    List<Exercise> exercises = exercisesMap.entries.map((entry) {
      return Exercise.fromMap(Map<String, dynamic>.from(entry.value), key: entry.key);
    }).toList();

    return Workout(
      name: map['name'] as String? ?? 'Unnamed Workout',
      exercises: exercises,
      key: key,
    );
  }
}
