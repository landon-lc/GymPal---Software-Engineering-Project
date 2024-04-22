import 'package:firebase_database/firebase_database.dart';

class Exercise {
  String name;
  String weight;
  String reps;
  String sets;
  bool isCompleted;
  String? key;
  int? createdAt;
  int? lastModified;

  Exercise({
    required this.name,
    required this.weight,
    required this.reps,
    required this.sets,
    this.isCompleted = false,
    this.key,
    this.createdAt, 
    this.lastModified,
  });

  factory Exercise.fromMap(Map<String, dynamic> map, {String? key}) {
    return Exercise(
      name: map['name'] ?? '',
      weight: map['weight'] ?? '',
      reps: map['reps'] ?? '',
      sets: map['sets'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
      key: key,
      createdAt: map['createdAt'],
      lastModified: map['lastModified'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'weight': weight,
      'reps': reps,
      'sets': sets,
      'isCompleted': isCompleted,
      'createdAt': createdAt ?? ServerValue.timestamp,
      'lastModified': ServerValue.timestamp,
    };
  }
}
