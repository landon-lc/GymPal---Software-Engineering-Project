import 'package:flutter/material.dart';

/// A StatelessWidget that displays a single exercise item in a list.
///
/// This tile represents an exercise with its name, weight, repetitions, sets,
/// and completion status. It provides a checkbox for marking the exercise as completed.
///
/// Each exercise is displayed with its details laid out in a row, alongside
/// a checkbox to toggle the completion status.
class ExerciseTile extends StatelessWidget {
  /// The name of the exercise.
  final String exerciseName;

  /// The weight used in the exercise, specified in pounds.
  final String weight;

  /// The number of repetitions for the exercise.
  final String reps;

  /// The number of sets for the exercise.
  final String sets;

  /// A boolean value that indicates if the exercise is completed.
  final bool isCompleted;

  /// A callback function that is called when the checkbox is toggled.
  ///
  /// This function should take a boolean value to update the exercise's completion status.
  final void Function(bool?) onCheckBoxChanged;

  /// Creates an [ExerciseTile] widget.
  ///
  /// Requires [exerciseName], [weight], [reps], [sets], [isCompleted], and [onCheckBoxChanged]
  /// to not be null. It displays exercise information in a list tile with a trailing checkbox
  /// to indicate completion status.
  const ExerciseTile({
    super.key,
    required this.exerciseName,
    required this.weight,
    required this.reps,
    required this.sets,
    required this.isCompleted,
    required this.onCheckBoxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200], // Background color for better UI distinction
      child: ListTile(
        title: Text(exerciseName),
        subtitle: Row(
          children: [
            Chip(label: Text('$weight lbs')), // Display weight with 'lbs' label
            const SizedBox(width: 4), // Provides spacing between chips
            Chip(label: Text('$reps reps')), // Display repetitions
            const SizedBox(width: 4), // Provides spacing between chips
            Chip(label: Text('$sets sets')), // Display sets
          ],
        ),
        trailing: Checkbox(
          value: isCompleted,
          onChanged: onCheckBoxChanged, // Checkbox to toggle completion
        ),
      ),
    );
  }
}
