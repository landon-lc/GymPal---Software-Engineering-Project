import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/exercise_tile.dart';
import '../models/workout_record.dart';
import '../models/exercise.dart';

/// A page that displays details of a specific workout including a list of exercises.
///
/// Allows users to add, edit, and delete exercises within a workout. Exercises can
/// also be marked as completed.
class WorkoutPage extends StatefulWidget {
  /// The name of the workout to display.
  final String workoutName;

  /// The unique identifier for the workout. Used to fetch and manipulate exercise data.
  final String workoutId;

  /// Constructs a [WorkoutPage] widget.
  ///
  /// Requires [workoutName] and [workoutId] to instantiate.
  const WorkoutPage({
    super.key,
    required this.workoutName,
    required this.workoutId,
  });

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

/// The state for [WorkoutPage] that manages exercise data and interactions.
class _WorkoutPageState extends State<WorkoutPage> {
  /// Controller for the exercise name input field.
  final TextEditingController exerciseNameController = TextEditingController();

  /// Controller for the weight input field.
  final TextEditingController weightController = TextEditingController();

  /// Controller for the sets input field.
  final TextEditingController setsController = TextEditingController();

  /// Controller for the reps input field.
  final TextEditingController repsController = TextEditingController();

  /// Displays a dialog for adding a new exercise to the workout.
  void _createNewExercise() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add a new exercise'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: exerciseNameController,
                decoration: const InputDecoration(labelText: 'Exercise Name')),
            TextField(
                controller: weightController,
                decoration: const InputDecoration(labelText: 'Weight')),
            TextField(
                controller: setsController,
                decoration: const InputDecoration(labelText: 'Sets')),
            TextField(
                controller: repsController,
                decoration: const InputDecoration(labelText: 'Reps')),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: _saveExercise,
            child: const Text('Save'),
          ),
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  /// Saves a new exercise to the database via the [WorkoutRecord] provider.
  ///
  /// This function retrieves the text from input fields, validates them, and calls
  /// the provider's method to save the data. It clears the form fields and closes
  /// the dialog upon successful saving.
  void _saveExercise() {
    final String exerciseName = exerciseNameController.text.trim();
    final String weight = weightController.text.trim();
    final String sets = setsController.text.trim();
    final String reps = repsController.text.trim();

    if (exerciseName.isNotEmpty &&
        weight.isNotEmpty &&
        sets.isNotEmpty &&
        reps.isNotEmpty) {
      Provider.of<WorkoutRecord>(context, listen: false).addExercises(
        widget.workoutId,
        exerciseName,
        weight,
        sets,
        reps,
      );
      Navigator.pop(context); // Close the dialog and clear form fields
      _clearFormFields();
    }
  }

  /// Clears all input fields after an exercise is saved or cancelled.
  void _clearFormFields() {
    exerciseNameController.clear();
    weightController.clear();
    setsController.clear();
    repsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.workoutName)),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewExercise,
        tooltip: 'Add New Exercise',
        child: const Icon(
            Icons.add), // Tooltip for better accessibility and user guidance.
      ),
      body: StreamBuilder<List<Exercise>>(
        stream: Provider.of<WorkoutRecord>(context)
            .getExercisesStream(widget.workoutId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No exercises found'));
          }

          final exercises = snapshot.data!;
          return ListView.builder(
            itemCount: exercises.length,
            itemBuilder: (context, index) {
              final exercise = exercises[index];
              return ExerciseTile(
                exerciseName: exercise.name,
                weight: exercise.weight,
                reps: exercise.reps,
                sets: exercise.sets,
                isCompleted: exercise.isCompleted,
                onCheckBoxChanged: (val) {
                  Provider.of<WorkoutRecord>(context, listen: false)
                      .checkOffExercise(
                          widget.workoutId, exercise.key ?? '', val ?? false);
                },
              );
            },
          );
        },
      ),
    );
  }
}
