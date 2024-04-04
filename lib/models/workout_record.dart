import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:test_drive/models/exercise.dart';
import 'package:test_drive/models/workout.dart';

class WorkoutRecord extends ChangeNotifier {
  List<Workout> workoutList = [];
  final DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  WorkoutRecord(){
    initWorkouts();
  }

  Stream<List<Workout>> get workoutsStream =>
      dbRef.child('workouts').onValue.map((event) {
        final data = event.snapshot.value;
        if (data is Map<dynamic, dynamic>) {
          return data.entries
              .map((e) => Workout.fromMap(Map<String, dynamic>.from(e.value),
                  key: e.key.toString()))
              .toList();
        } else {
          return [];
        }
      });

  Future<void> initWorkouts() async {
    workoutsStream.listen((workouts){
      workoutList = workouts;
      notifyListeners();
    });
  }

  void addWorkout(String name) {
    final newWorkoutRef = dbRef.child('workouts').push();
    final newWorkout = Workout(name: name, exercises: [], key: newWorkoutRef.key);

    newWorkoutRef.set(newWorkout.toMap()).then((_) {
      print('Workout added successfully with key ${newWorkoutRef.key}');
    }).catchError((error) {
      print('Failed to add workout: $error');
    });
    workoutList.add(newWorkout);
    notifyListeners();
  }

  void addExercises(String workoutId, String exerciseName, String weight,
      String reps, String sets) {
    dbRef.child('workouts/$workoutId/exercises').push().set({
      'name': exerciseName,
      'weight': weight,
      'reps': reps,
      'sets': sets,
      'isCompleted': false,
    });
  }

  void updateWorkoutName(String workoutId, String newName) {
    dbRef.child('workouts/$workoutId').update({
      'name': newName,
    }).then((_) {
      int index = workoutList.indexWhere((workout) => workout.key == workoutId);
      if (index != -1) {
        workoutList[index].name = newName;
        notifyListeners();
      }
      print('Workout name updated successfully');
    }).catchError((error) {
      print('Failed to update workout name: $error');
    });
  }

  void checkOffExercise(String workoutId, String exerciseId, bool isCompleted) {
    dbRef.child('workouts/$workoutId/exercises/$exerciseId').update({
      'isCompleted': isCompleted,
    });
  }

  void deleteWorkout(String workoutId) {
    dbRef.child('workouts/$workoutId').remove().then((_) {
      print('Workout deleted successfully from Firebase');
    }).catchError((error) {
      print('Failed to delete workout: $error');
    });
    workoutList.removeWhere((workout) => workout.key == workoutId);
    notifyListeners();
  }

  void editWorkout(String workoutId, String newName) {
    dbRef.child('workouts/$workoutId').update({'name': newName}).catchError((error) {
    print('Failed to update workout name: $error');
  });
    
    final int index = workoutList.indexWhere((workout) => workout.key == workoutId);
    if (index != -1) {
      workoutList[index].name = newName;
      notifyListeners();
    }
  }

  Stream<List<Exercise>> getExercisesStream(String workoutId) {
    return dbRef.child('workouts/$workoutId/exercises').onValue.map((event) {
      final data = event.snapshot.value;
      if (data is Map<dynamic, dynamic>) {
        return data.entries
            .map((e) => Exercise.fromMap(Map<String, dynamic>.from(e.value),
                key: e.key.toString()))
            .toList();
      } else {
        return [];
      }
    });
  }
}
