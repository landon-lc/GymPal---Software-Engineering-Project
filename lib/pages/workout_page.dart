import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_drive/components/exercise_tile.dart';
import 'package:test_drive/data/workout_record.dart';
import 'package:test_drive/models/exercise.dart';

class WorkoutPage extends StatefulWidget {
  final String workoutName;
  final String workoutId;

  const WorkoutPage({Key? key, required this.workoutName, required this.workoutId}) : super(key: key);

  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  final TextEditingController exerciseNameController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController setsController = TextEditingController();
  final TextEditingController repsController = TextEditingController();

  void _createNewExercise() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add a new exercise'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: exerciseNameController, decoration: const InputDecoration(labelText: 'Exercise Name')),
            TextField(controller: weightController, decoration: const InputDecoration(labelText: 'Weight')),
            TextField(controller: setsController, decoration: const InputDecoration(labelText: 'Sets')),
            TextField(controller: repsController, decoration: const InputDecoration(labelText: 'Reps')),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              _saveExercise();
            },
            child: const Text('Save'),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _saveExercise() {
    final String exerciseName = exerciseNameController.text.trim();
    final String weight = weightController.text.trim();
    final String sets = setsController.text.trim();
    final String reps = repsController.text.trim();

    if (exerciseName.isNotEmpty && weight.isNotEmpty && sets.isNotEmpty && reps.isNotEmpty) {
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
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<Exercise>>(
        stream: Provider.of<WorkoutRecord>(context).getExercisesStream(widget.workoutId),
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
                  Provider.of<WorkoutRecord>(context, listen: false).checkOffExercise(widget.workoutId, exercise.key ?? '', val ?? false);
                },
              );
            },
          );
        },
      ),
    );
  }
}
