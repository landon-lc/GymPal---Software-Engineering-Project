import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_drive/src/components/exercise_tile.dart';
import 'package:test_drive/src/models/workout_record.dart';
import 'package:test_drive/src/models/exercise.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({
    super.key,
    required this.workoutName,
    required this.workoutId,
  });

  final String workoutName;
  final String workoutId;

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
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

  /// Edits the details of an existing exercise.
  ///
  /// This function takes in a [BuildContext] and an [Exercise] object. It initializes
  /// four [TextEditingController]s with the current details of the exercise. These controllers
  /// are used to read text from and insert text into the text fields of the exercise form.
  ///
  /// The [nameController] is initialized with the current name of the exercise.
  /// The [weightController] is initialized with the current weight used in the exercise.
  /// The [repsController] is initialized with the current number of repetitions of the exercise.
  /// The [setsController] is initialized with the current number of sets of the exercise.
  ///
  /// [context] is the build context in which this function is being called.
  /// [exercise] is the exercise object whose details are to be edited.
  void _editExercise(BuildContext context, Exercise exercise) {
    TextEditingController nameController =
        TextEditingController(text: exercise.name);
    TextEditingController weightController =
        TextEditingController(text: exercise.weight);
    TextEditingController repsController =
        TextEditingController(text: exercise.reps);
    TextEditingController setsController =
        TextEditingController(text: exercise.sets);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Exercise'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Exercise Name'),
                ),
                TextField(
                  controller: weightController,
                  decoration: const InputDecoration(labelText: 'Weight'),
                ),
                TextField(
                  controller: repsController,
                  decoration: const InputDecoration(labelText: 'Reps'),
                ),
                TextField(
                  controller: setsController,
                  decoration: const InputDecoration(labelText: 'Sets'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                if (exercise.key != null) {
                  Provider.of<WorkoutRecord>(context, listen: false)
                      .editExercise(
                    widget.workoutId,
                    exercise.key!,
                    nameController.text.trim(),
                    weightController.text.trim(),
                    repsController.text.trim(),
                    setsController.text.trim(),
                    exercise.isCompleted,
                  );
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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

  ///Clears all information from the following fields
  void _clearFormFields() {
    exerciseNameController.clear();
    weightController.clear();
    setsController.clear();
    repsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2f2f2f),
      appBar: AppBar(
        title: Text(
          widget.workoutName,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white), // White text color
        ),
        centerTitle: true, // Centers the title text in AppBar
        backgroundColor:
            const Color(0xff3ea9a9), // Sets the AppBar background to teal
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewExercise,
        backgroundColor: const Color(0xff3ea9a9),
        child: const Icon(
            Icons.add), // Sets the FloatingActionButton color to teal
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
              return Slidable(
                key: ValueKey(exercise.key),
                startActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) => _editExercise(context, exercise),
                      backgroundColor: Colors.blue,
                      icon: Icons.edit,
                      label: 'Edit',
                    ),
                    SlidableAction(
                      onPressed: (context) {
                        Provider.of<WorkoutRecord>(context, listen: false)
                            .deleteExercise(
                                widget.workoutId, exercise.key ?? '');
                      },
                      backgroundColor: Colors.red,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 8.0),
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ExerciseTile(
                    exerciseName: exercise.name,
                    weight: exercise.weight,
                    reps: exercise.reps,
                    sets: exercise.sets,
                    isCompleted: exercise.isCompleted,
                    onCheckBoxChanged: (val) {
                      Provider.of<WorkoutRecord>(context, listen: false)
                          .checkOffExercise(widget.workoutId,
                              exercise.key ?? '', val ?? false);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
