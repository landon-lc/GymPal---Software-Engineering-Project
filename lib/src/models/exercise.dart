import 'package:firebase_database/firebase_database.dart';

/// Represents a single exercise within a workout, detailing its various attributes
/// such as name, weight used, repetitions, sets, and completion status.
///
/// This class can serialize and deserialize exercise data from and to a map,
/// which is useful for storing and retrieving from a database like Firebase.
class Exercise {
  /// The name of the exercise.
  String name;

  /// The weight used for the exercise, typically in pounds or kilograms.
  String weight;

  /// The number of repetitions for this exercise.
  String reps;

  /// The number of sets for this exercise.
  String sets;

  /// Indicates whether the exercise has been completed.
  bool isCompleted;

  /// Optional key that might be used to identify the exercise in a database.
  String? key;

  /// Timestamp marking the creation time of this exercise record.
  int? createdAt;

  /// Timestamp marking the last modification time of this exercise record.
  int? lastModified;

  /// Constructs an [Exercise] with required fields [name], [weight], [reps], [sets],
  /// and optional fields [isCompleted], [key], [createdAt], and [lastModified].
  ///
  /// By default, [isCompleted] is set to false if not provided.
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

  /// Creates an [Exercise] from a map of key/value pairs, typically from database data.
  ///
  /// Optionally accepts a [key] which can be used to link this exercise back to a database record.
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

  /// Converts an [Exercise] instance to a map of key/value pairs, suitable for database storage.
  ///
  /// This method includes dynamic values for [createdAt] and [lastModified] using
  /// `ServerValue.timestamp` to ensure accurate timestamping by the database server.
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
