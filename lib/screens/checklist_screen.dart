import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_drive/data/workout_record.dart';
import 'workout_screen.dart'; // Make sure the import path is correct

class ChecklistPage extends StatefulWidget {
  const ChecklistPage({super.key});

  @override
  State<ChecklistPage> createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  final TextEditingController newWorkoutNameController =
      TextEditingController();

  void createNewWorkout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create a new workout'),
        content: TextField(
          controller: newWorkoutNameController,
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

  void goToWorkoutPage(String workoutName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutScreen(workoutName: workoutName),
      ),
    );
  }

  void save() {
    String newWorkoutName = newWorkoutNameController.text;
    if (newWorkoutName.isNotEmpty) {
      Provider.of<WorkoutRecord>(context, listen: false)
          .addWorkout(newWorkoutName);
      Navigator.pop(context); // Close the dialog
      clear();
    }
  }

  void cancel() {
    Navigator.pop(context); // Close the dialog
    clear();
  }

  void clear() {
    newWorkoutNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutRecord>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Workout Tracker'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewWorkout,
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: value.getWorkoutList().length,
          itemBuilder: (context, index) => ListTile(
            title: Text(value.getWorkoutList()[index].name),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () =>
                  goToWorkoutPage(value.getWorkoutList()[index].name),
            ),
          ),
        ),
      ),
    );
  }
}
