import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_drive/components/exercise_tile.dart';
import 'package:test_drive/data/workout_record.dart';
import 'package:test_drive/models/exercise.dart';

class WorkoutPage extends StatefulWidget {
  final String workoutName;
  final String workoutId; // This needs to be passed when navigating to this page

  const WorkoutPage({Key? key, required this.workoutName, required this.workoutId}) : super(key: key);

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  final exerciseNameController = TextEditingController();
  final weightController = TextEditingController();
  final setsController = TextEditingController();
  final repsController = TextEditingController();

  void createNewExercise() {
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
          MaterialButton(onPressed: save, child: const Text('Save')),
          MaterialButton(onPressed: cancel, child: const Text('Cancel')),
        ],
      ),
    );
  }

  void save() {
    String newExerciseName = exerciseNameController.text;
    String weight = weightController.text;
    String reps = repsController.text;
    String sets = setsController.text;

    if (newExerciseName.isNotEmpty) {
      Provider.of<WorkoutRecord>(context, listen: false).addExercises(
        widget.workoutId, 
        newExerciseName, 
        weight, 
        reps, 
        sets
      );
      Navigator.pop(context); // Close the dialog
      clear();
    }
  }

  void cancel() {
    Navigator.pop(context); // Close the dialog
    clear();
  }

  void clear() {
    exerciseNameController.clear();
    weightController.clear();
    setsController.clear();
    repsController.clear();
  }

  void onCheckBoxChanged(bool? newVal, String exerciseId) {
    if (newVal != null) {
      Provider.of<WorkoutRecord>(context, listen: false).checkOffExercise(widget.workoutId, exerciseId, newVal);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.workoutName)),       
      floatingActionButton: FloatingActionButton(
        onPressed: createNewExercise,
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
                onCheckBoxChanged: (val) => onCheckBoxChanged(val, exercise.key!),
              );
            },
          );
        },
      ),
    );
  }
}
