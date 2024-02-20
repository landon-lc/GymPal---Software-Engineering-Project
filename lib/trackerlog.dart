class Exercise {
  int sets;
  int reps;
  String name;
  String group;

  Exercise({required this.sets, required this.reps, required this.name, required this.group});

  static List<Exercise> sampleExercises = [
    Exercise(sets: 3, reps: 12, name: 'Push-ups', group:'Chest'),
    Exercise(sets: 4, reps: 10, name: 'Squats', group: 'Legs'),
  ];
}

class Workout {
  List<Exercise> exercises;
  String name;
  int duration; // in minutes

  Workout({required this.exercises, required this.name, required this.duration});

  static List<Workout> sampleWorkouts = [
    Workout(exercises: Exercise.sampleExercises, name: 'Morning Routine', duration: 30),
  ];
}

class WorkoutRecord {
  Workout workout;
  DateTime dateTime;

  WorkoutRecord({required this.workout, required this.dateTime});

  static List<WorkoutRecord> sampleRecords = [
    WorkoutRecord(workout: Workout.sampleWorkouts.first, dateTime: DateTime.now()),
  ];
}
