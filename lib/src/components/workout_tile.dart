import 'package:flutter/material.dart';
import '../models/workout.dart';

/// A StatelessWidget that represents a single workout item in a list.
///
/// Displays the name of the workout along with a count of how many exercises
/// it contains. Provides buttons for editing and deleting the workout as well
/// as a tap handler for viewing details.
class WorkoutTile extends StatelessWidget {
  /// The workout data to display.
  final Workout workout;

  /// The callback that is called when the tile is tapped.
  ///
  /// This is typically used to view workout details.
  final VoidCallback? onTap;

  /// The callback that is called when the edit icon is tapped.
  ///
  /// This is typically used to open an interface for editing the workout details.
  final VoidCallback? onEdit;

  /// The callback that is called when the delete icon is tapped.
  ///
  /// This is typically used to delete the workout from a list or database.
  final VoidCallback? onDelete;

  /// Constructs a [WorkoutTile].
  ///
  /// Requires a [workout] parameter to display the workout data.
  /// Optionally takes [onTap], [onEdit], and [onDelete] callbacks which handle user interaction.
  const WorkoutTile({
    super.key,
    required this.workout,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(workout.name),
      subtitle: Text('Exercises: ${workout.exercises.length}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: onEdit,
            tooltip:
                'Edit Workout', // Tooltip provides additional context for accessibility.
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onDelete,
            tooltip:
                'Delete Workout', // Tooltip provides additional context for accessibility.
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
