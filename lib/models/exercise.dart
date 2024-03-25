class Exercise {
  final String name;
  final String weight;
  final String reps;
  final String sets;
  bool isCompleted;

  Exercise({
    required this.name,
    required this.weight,
    required this.reps,
    required this.sets,
    this.isCompleted = false,
  });
}

//List<Exercise> sampleExercises = [
//    Exercise(sets: 3, reps: 12, name: 'Push-ups', group: 'Chest'),
//    Exercise(sets: 4, reps: 10, name: 'Squats', group: 'Legs'),
//  ];
