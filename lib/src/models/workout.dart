import 'package:test_drive/src/models/exercise.dart';

/// Represents a workout containing multiple exercises.
///
/// This class holds details about a workout session including its name,
/// a list of exercises performed, and the timestamp when the workout was created or recorded.
class Workout {
  /// The name of the workout.
  String name;

  /// A list of [Exercise] objects representing the exercises included in this workout.
  List<Exercise> exercises;

  /// An optional key that might be used to uniquely identify the workout in a database.
  String? key;

  /// The timestamp marking when the workout was created or last updated.
  DateTime timestamp;

  /// Constructs a [Workout] with the required parameters [name], [exercises], and [timestamp].
  /// An optional [key] can also be provided if the workout needs to be associated with a unique identifier.
  Workout(
      {required this.name,
      required this.exercises,
      this.key,
      required this.timestamp});

  /// Converts a [Workout] instance into a map of key/value pairs.
  ///
  /// This method is typically used to serialize the [Workout] object for storage in a database.
  /// The exercises are converted to a list of maps, each representing an [Exercise].
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'exercises': exercises.map((e) => e.toMap()).toList(),
      'timestamp': timestamp.toIso8601String(),
    };
  }

  /// Creates a [Workout] from a map of key/value pairs.
  ///
  /// The [map] argument is expected to contain keys for 'name', 'exercises', and 'timestamp'.
  /// [exercises] should be a list of maps where each map contains details of an [Exercise].
  /// If [key] is provided, it is used as the workout's unique identifier.
  ///
  /// The timestamp is parsed into a DateTime object. If the timestamp is missing, the current time is used.
  factory Workout.fromMap(Map<String, dynamic> map, {String? key}) {
    var exercisesData = map['exercises'];
    List<Exercise> exercises;
    DateTime parsedTimestamp = map['timestamp'] != null
        ? DateTime.parse(map['timestamp'])
        : DateTime.now();

    if (exercisesData is List<dynamic>) {
      exercises = exercisesData
          .map((e) => Exercise.fromMap(e as Map<String, dynamic>))
          .toList();
    } else {
      exercises = [];
    }

    return Workout(
      name: map['name'] as String? ?? '',
      exercises: exercises,
      key: key,
      timestamp: parsedTimestamp,
    );
  }
}
