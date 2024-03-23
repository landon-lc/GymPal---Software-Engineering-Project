import '../models/workout.dart';

class WorkoutRecord {
  Workout workout;
  DateTime dateTime;

  WorkoutRecord({required this.workout, required this.dateTime});

}

  // List<WorkoutRecord> sampleRecords = [
  //   WorkoutRecord(
  //       workout: sampleWorkouts.first, dateTime: DateTime.now()),
  // ];