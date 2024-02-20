class Exercise {
  int sets;
  int reps;
  String name;
  String group;

  Exercise(
      {required this.sets,
      required this.reps,
      required this.name,
      required this.group});
}
List<Exercise> sampleExercises = [
    Exercise(sets: 3, reps: 12, name: 'Push-ups', group: 'Chest'),
    Exercise(sets: 4, reps: 10, name: 'Squats', group: 'Legs'),
  ];