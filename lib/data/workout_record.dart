import 'package:flutter/material.dart';
import 'package:test_drive/models/exercise.dart';
import '../models/workout.dart';

//default workout
class WorkoutRecord extends ChangeNotifier {
  List<Workout> workoutList = [
    Workout(
      name: 'Push Day',
      exercises: [
        Exercise(name: 'Bench Press', weight: '135', reps: '10', sets: '3'),
      ],
    ),
    Workout(
      name: 'Pull Day',
      exercises: [
        Exercise(name: 'Pull Ups', weight: 'BW', reps: '10', sets: '3'),
      ],
    )
  ];

//list of workouts
  List<Workout> getWorkoutList() {
    return workoutList;
  }

  //length of exercises
  int numOfExercises(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    return relevantWorkout.exercises.length;
  }

  //add a workout
  void addWorkout(String name) {
    workoutList.add(Workout(name: name, exercises: []));

    notifyListeners();
  }

  //add exercises
  void addExercises(String workoutName, String exerciseName, String weight,
      String reps, String sets) {
    //relevemnt workout instantiation
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    relevantWorkout.exercises.add(
      Exercise(name: exerciseName, weight: weight, reps: reps, sets: sets),
    );
    notifyListeners();
  }

  //check off exercises
  void checkOffExercises(String workoutName, String exerciseName) {
    //find relevent workout
    Exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);

    //check off boolean
    relevantExercise.isCompleted = !relevantExercise.isCompleted;

    notifyListeners();
  }

  //return relevent workout
  Workout getRelevantWorkout(String workoutName) {
    Workout relevantWorkout =
        workoutList.firstWhere((workout) => workout.name == workoutName);

    return relevantWorkout;
  }
  //return relevant exercises

  Exercise getRelevantExercise(String workoutName, String exerciseName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    Exercise relevantExercise = relevantWorkout.exercises
        .firstWhere((exercise) => exercise.name == exerciseName);

    return relevantExercise;
  }
}

//  List<WorkoutRecord> sampleRecords = [
//    WorkoutRecord(
//        workout: sampleWorkouts.first, dateTime: DateTime.now()),
//  ];
