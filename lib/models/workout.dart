import 'exercise.dart';

class Workout {
  List<Exercise> exercises;
  String name;
  int duration; // in minutes

  Workout(
      {required this.exercises, required this.name, required this.duration});
}

List<Workout> sampleWorkouts = [
    Workout(
        exercises: sampleExercises,
        name: 'Morning Routine',
        duration: 30),
  ];