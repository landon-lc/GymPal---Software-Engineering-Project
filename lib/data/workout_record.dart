import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:test_drive/models/exercise.dart'; 
import 'package:test_drive/models/workout.dart'; 

class WorkoutRecord extends ChangeNotifier {
  final DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  Stream<List<Workout>> get workoutsStream => dbRef.child('workouts').onValue.map((event) {
    final data = event.snapshot.value as Map<dynamic, dynamic>?;
    return data != null
        ? data.entries.map((entry) => Workout.fromMap(Map<String, dynamic>.from(entry.value), key: entry.key)).toList()
        : [];
  });

  void addWorkout(String name) {
    dbRef.child('workouts').push().set({'name': name, 'exercises': []});
  }

  void addExercises(String workoutId, String exerciseName, String weight, String reps, String sets) {
    dbRef.child('workouts/$workoutId/exercises').push().set({
      'name': exerciseName,
      'weight': weight,
      'reps': reps,
      'sets': sets,
      'isCompleted': false,
    });
  }

  void updateWorkoutName(String workoutId, String newName) {
    dbRef.child('workouts/$workoutId').update({'name': newName});
  }

  void checkOffExercise(String workoutId, String exerciseId, bool isCompleted) {
    dbRef.child('workouts/$workoutId/exercises/$exerciseId').update({'isCompleted': isCompleted});
  }

  Stream<List<Exercise>> getExercisesStream(String workoutId) {
    return dbRef.child('workouts/$workoutId/exercises').onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      return data != null
          ? data.entries.map((entry) => Exercise.fromMap(Map<String, dynamic>.from(entry.value), key: entry.key)).toList()
          : [];
    });
  }
}
