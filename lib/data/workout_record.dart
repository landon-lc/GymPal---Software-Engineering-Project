import 'package:flutter/material.dart';
import 'package:test_drive/models/exercise.dart';
import '../models/workout.dart';
import 'package:firebase_database/firebase_database.dart';

class WorkoutRecord extends ChangeNotifier {
  List<Workout> workoutList = [
    Workout(
      name: 'Push Day',
      exercises: [
        Exercise(
          name: 'Bench Press',
          weight: '135',
          reps: '10',
          sets: '3',
        ),
      ],
    ),
    Workout(
      name: 'Pull Day',
      exercises: [
        Exercise(
          name: 'Pull Ups',
          weight: 'BW',
          reps: '10',
          sets: '3',
        ),
      ],
    ),
  ];

  List<Workout> getWorkoutList() {
    return workoutList;
  }

  int numOfExercises(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    return relevantWorkout.exercises.length;
  }

  void addWorkout(String name) {
    workoutList.add(Workout(name: name, exercises: []));
    notifyListeners();
  }

  void addExercises(String workoutName, String exerciseName, String weight, String reps, String sets) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    relevantWorkout.exercises.add(Exercise(
      name: exerciseName,
      weight: weight,
      reps: reps,
      sets: sets,
    ));
    notifyListeners();
  }

  void checkOffExercises(String workoutName, String exerciseName) {
    Exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);
    relevantExercise.isCompleted = !relevantExercise.isCompleted;
    notifyListeners();
  }

  Workout getRelevantWorkout(String workoutName) {
    return workoutList.firstWhere((workout) => workout.name == workoutName);
  }

  Exercise getRelevantExercise(String workoutName, String exerciseName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    return relevantWorkout.exercises.firstWhere((exercise) => exercise.name == exerciseName);
  }

  void updateWorkoutName(int index, String newName) {
    var updatedWorkout = workoutList[index].copyWith(name: newName);
    workoutList[index] = updatedWorkout;
    notifyListeners();
  }

  // Future method to update the workout name in Firebase Firestore could be added here
}
