class Exercise {
  final String name;
  final String weight;
  final String reps;
  final String sets;
  bool isCompleted;
  final String? key; 

  Exercise({
    required this.name,
    required this.weight,
    required this.reps,
    required this.sets,
    this.isCompleted = false,
    this.key, 
  });

  factory Exercise.fromMap(Map<String, dynamic> map, {String? key}) {
    return Exercise(
      name: map['name'] ?? '',
      weight: map['weight'] ?? '',
      reps: map['reps'] ?? '',
      sets: map['sets'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
      key: key, 
    );
  }
}
