import 'package:test_drive/models/exercise.dart';

import '../models/workout.dart';

class WorkoutRecord {
  List<Workout> workoutList = [
    Workout(
      name: 'Push Day', 
      exercises: [
        Exercise(
          name: 'Bench Press', 
          weight: '135', 
          reps: '10', 
          sets: '3'
        )
      ]
    )
  ];
}

//  List<WorkoutRecord> sampleRecords = [
//    WorkoutRecord(
//        workout: sampleWorkouts.first, dateTime: DateTime.now()),
//  ];