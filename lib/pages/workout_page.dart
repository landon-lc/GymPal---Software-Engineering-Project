import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_drive/components/exercise_tile.dart';
import 'package:test_drive/data/workout_record.dart';

class WorkoutPage extends StatefulWidget {
  final String workoutName;
  const WorkoutPage({super.key, required this.workoutName});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  //checks box on checklist
  void onCheckBoxChanged(String workoutName, String exerciseName) {
    Provider.of<WorkoutRecord>(context, listen: false).checkOffExercises(workoutName, exerciseName); 
  }

  //text controllers
  final exerciseNameController = TextEditingController();
  final weightController = TextEditingController();
  final setsController = TextEditingController();
  final repsController = TextEditingController();

  //create new workout
  void createNewExercise() {
    showDialog(
      context: context, 
      builder: (context) =>AlertDialog(
        title: Text('Add a new exercse'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //exercise name
            TextField(
              controller: exerciseNameController,
            ),

            //weight
            TextField(
              controller: weightController,
            ),
            //sets
            TextField(
              controller: setsController,
            ),
            //reps
            TextField(
              controller: repsController,
            ),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: save,
            child: const Text('Save'),
          ),
          MaterialButton(
            onPressed: cancel,
            child: const Text('Cancel'),
          ),
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
        widget.workoutName, 
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

  @override
  Widget build(BuildContext context) {
    return Consumer <WorkoutRecord>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(title: Text(widget.workoutName)),       
          floatingActionButton: FloatingActionButton(
            onPressed: createNewExercise,
            child: Icon(Icons.add),
          ),
          body: ListView.builder(
          itemCount: value.numOfExercises(widget.workoutName),
          itemBuilder: (context, index) => ExerciseTile(
            exerciseName: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .name, 
            weight: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .weight, 
            reps: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .reps, 
            sets: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .sets, 
            isCompleted: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .isCompleted, 
            onCheckBoxChanged: (val) => onCheckBoxChanged(
                widget.workoutName, 
                value
                    .getRelevantWorkout(widget.workoutName)
                    .exercises[index]
                    .name, 
            ),
          ),
        ),
      ),    
    );
  }
}