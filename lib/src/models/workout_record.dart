import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:test_drive/src/models/exercise.dart';
import 'package:test_drive/src/models/workout.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WorkoutRecord extends ChangeNotifier {
  List<Workout> workoutList = [];
  final DatabaseReference dbRef = FirebaseDatabase.instance.ref();
  final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

  WorkoutRecord() {
    initWorkouts();
 }

  Stream<List<Workout>> workoutsStream({DateTime? start, DateTime? end}) {
    Query query = dbRef.child('users/$userId/workouts').orderByChild('timestamp');
    if (start != null) {
      query = query.startAt(start.toIso8601String());
    }
    if (end != null) {
      query = query.endAt(end.toIso8601String());
    }

    return query.onValue.map((event) {
      final data = event.snapshot.value;
      if (data is Map<dynamic, dynamic>) {
        return data.entries
            .map((e) => Workout.fromMap(Map<String, dynamic>.from(e.value), key: e.key.toString()))
            .toList();
      } else {
        return [];
      }
    });
  }

  Future<void> initWorkouts() async {
    workoutsStream().listen((workouts) {
      workoutList = workouts;
      notifyListeners();
    });
  }

  void addWorkout(String name) {
    final newWorkoutRef = dbRef.child('users/$userId/workouts').push();
    final now = DateTime.now();
    newWorkoutRef.set({
      'name': name,
      'exercises': [],
      'timestamp': now.toIso8601String(),
    }).then((_) {
      workoutList.add(Workout(name: name, exercises: [], key: newWorkoutRef.key, timestamp: now));
      notifyListeners();
      print('Workout added successfully with key ${newWorkoutRef.key}');
    }).catchError((error) {
      print('Failed to add workout: $error');
    });
  }

  void addExercises(String workoutId, String exerciseName, String weight, String reps, String sets) {
    dbRef.child('users/$userId/workouts/$workoutId/exercises').push().set({
      'name': exerciseName,
      'weight': weight,
      'reps': reps,
      'sets': sets,
      'isCompleted': false,
    });
  }

  void updateWorkoutName(String workoutId, String newName) {
    dbRef.child('users/$userId/workouts/$workoutId').update({
      'name': newName,
    }).then((_) {
      int index = workoutList.indexWhere((workout) => workout.key == workoutId);
      if (index != -1) {
        workoutList[index].name = newName;
        notifyListeners();
      }
    }).catchError((error) {
      print('Failed to update workout name: $error');
    });
  }

  void checkOffExercise(String workoutId, String exerciseId, bool isCompleted) {
    dbRef.child('users/$userId/workouts/$workoutId/exercises/$exerciseId').update({
      'isCompleted': isCompleted,
      }).then((_) {
    print('Exercise status updated successfully.');
  }).catchError((error) {
    print('Failed to update exercise status: $error');
    });
  }

  void deleteWorkout(String workoutId) {
    dbRef.child('users/$userId/workouts/$workoutId').remove().then((_) {
      workoutList.removeWhere((workout) => workout.key == workoutId);
      notifyListeners();
      print('Workout deleted successfully from Firebase');
    }).catchError((error) {
      print('Failed to delete workout: $error');
    });
  }

  void editWorkout(String workoutId, String newName) {
    dbRef.child('users/$userId/workouts/$workoutId').update({'name': newName});
    int index = workoutList.indexWhere((workout) => workout.key == workoutId);
    if (index != -1) {
      workoutList[index].name = newName;
      notifyListeners();
    }
  }

  void deleteExercise(String workoutId, String exerciseId) {
  dbRef.child('users/$userId/workouts/$workoutId/exercises/$exerciseId').remove().then((_) {
    print('Exercise deleted successfully from Firebase');
    notifyListeners();  
  }).catchError((error) {
    print('Failed to delete exercise: $error');
  });
}

  void editExercise(String workoutId, String exerciseId, String newName, String newWeight, String newReps, String newSets, bool newIsCompleted) {
  dbRef.child('users/$userId/workouts/$workoutId/exercises/$exerciseId').update({
    'name': newName,
    'weight': newWeight,
    'reps': newReps,
    'sets': newSets,
    'isCompleted': newIsCompleted
  }).then((_) {
    print('Exercise updated successfully');
    notifyListeners();  
  }).catchError((error) {
    print('Failed to update exercise: $error');
  });
}


  Stream<List<Exercise>> getExercisesStream(String workoutId) {
    return dbRef.child('users/$userId/workouts/$workoutId/exercises').onValue.map((event) {
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