import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:test_drive/src/models/exercise.dart';
import 'package:test_drive/src/models/workout.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Manages the state and database operations for workout records in a Firebase database.
///
/// This class provides functionality to create, read, update, and delete workouts
/// and exercises for a specific user. It uses Firebase Realtime Database to store and manage data.

class WorkoutRecord extends ChangeNotifier {
  List<Workout> workoutList = [];

  /// Firebase database reference used to perform CRUD operations.
  final DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  /// The current user's ID from FirebaseAuth, used to scope data access.
  final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

  /// Tracks the current page for pagination of workouts.
  int _currentPage = 0;

  /// Defines the number of workouts to be loaded per page.
  final int _pageSize = 10; // Number of workouts per page

  /// Initializes workouts by setting up a listener on the paginated workout stream.
  WorkoutRecord() {
    initWorkouts();
  }

  /// Provides a stream of paginated workouts, optionally filtered by a start and end date.
  ///
  /// Each call retrieves one page of workouts. Subsequent calls retrieve the next page.
  /// If `start` and/or `end` are provided, filters the workouts to those within the given date range.
  Stream<List<Workout>> paginatedWorkoutsStream(
      {DateTime? start, DateTime? end}) {
    Query query = dbRef
        .child('users/$userId/workouts')
        .orderByChild('timestamp')
        .limitToFirst((_currentPage + 1) * _pageSize);

    if (start != null && end == null) {
      // Assuming end date is today if not provided
      end = DateTime.now();
    }
    if (start == null && end != null) {
      // Assuming start date is a reasonable past limit if not provided
      start = DateTime.now().subtract(const Duration(days: 365));
    }
    if (start != null) query = query.startAt(start.toUtc().toIso8601String());
    if (end != null) query = query.endAt(end.toUtc().toIso8601String());

    return query.onValue.map((event) {
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
  }

  /// Advances to the next page of workouts.
  void nextPage() {
    _currentPage++;
    notifyListeners();
  }

  /// Initializes the workout list and sets up a listener to update local data on changes.
  Future<void> initWorkouts() async {
    paginatedWorkoutsStream().listen((workouts) {
      workoutList = workouts;
      notifyListeners();
    });
  }

  /// Adds a new workout to Firebase under the current user's ID with the current timestamp.
  void addWorkout(String name) {
    final newWorkoutRef = dbRef.child('users/$userId/workouts').push();
    final now = DateTime.now().toUtc(); // Convert to UTC
    newWorkoutRef.set({
      'name': name,
      'exercises': [],
      'timestamp': now.toIso8601String(),
    }).then((_) {
      workoutList.add(Workout(
          name: name, exercises: [], key: newWorkoutRef.key, timestamp: now));
      notifyListeners();
      print('Workout added successfully with key ${newWorkoutRef.key}');
    }).catchError((error) {
      print('Failed to add workout: $error');
    });
  }

  /// Adds exercises to a specific workout in Firebase.
  void addExercises(String workoutId, String exerciseName, String weight,
      String reps, String sets) {
    dbRef.child('users/$userId/workouts/$workoutId/exercises').push().set({
      'name': exerciseName,
      'weight': weight,
      'reps': reps,
      'sets': sets,
      'isCompleted': false,
    });
  }

  /// Updates the name of an existing workout.
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
    dbRef
        .child('users/$userId/workouts/$workoutId/exercises/$exerciseId')
        .update({
      'isCompleted': isCompleted,
    }).then((_) {
      print('Exercise status updated successfully.');
    }).catchError((error) {
      print('Failed to update exercise status: $error');
    });
  }

  /// Marks an exercise as completed or not completed.
  void deleteWorkout(String workoutId) {
    dbRef.child('users/$userId/workouts/$workoutId').remove().then((_) {
      workoutList.removeWhere((workout) => workout.key == workoutId);
      notifyListeners();
      print('Workout deleted successfully from Firebase');
    }).catchError((error) {
      print('Failed to delete workout: $error');
    });
  }

  /// Edits the name of a workout.
  void editWorkout(String workoutId, String newName) {
    dbRef.child('users/$userId/workouts/$workoutId').update({'name': newName});
    int index = workoutList.indexWhere((workout) => workout.key == workoutId);
    if (index != -1) {
      workoutList[index].name = newName;
      notifyListeners();
    }
  }

  /// Deletes an exercise from a workout.
  void deleteExercise(String workoutId, String exerciseId) {
    dbRef
        .child('users/$userId/workouts/$workoutId/exercises/$exerciseId')
        .remove()
        .then((_) {
      print('Exercise deleted successfully from Firebase');
      notifyListeners();
    }).catchError((error) {
      print('Failed to delete exercise: $error');
    });
  }

  /// Edits an exercise in a workout.
  void editExercise(String workoutId, String exerciseId, String newName,
      String newWeight, String newReps, String newSets, bool newIsCompleted) {
    dbRef
        .child('users/$userId/workouts/$workoutId/exercises/$exerciseId')
        .update({
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

  /// Retrieves a stream of exercises for a specific workout.
  ///
  /// This method listens for real-time updates to a workout's exercises, reflecting any additions, deletions, or modifications.
  Stream<List<Exercise>> getExercisesStream(String workoutId) {
    return dbRef
        .child('users/$userId/workouts/$workoutId/exercises')
        .onValue
        .map((event) {
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
