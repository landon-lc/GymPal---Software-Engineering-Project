import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_drive/data/workout_record.dart';
import 'workout_page.dart'; // Ensure this path is correct

class ChecklistPage extends StatefulWidget {
  const ChecklistPage({super.key});

  @override
  State<ChecklistPage> createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  final TextEditingController newWorkoutNameController = TextEditingController();

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

  void editWorkoutName(int index) {
    // Pre-fill the TextEditingController with the current workout name
    newWorkoutNameController.text = Provider.of<WorkoutRecord>(context, listen: false).getWorkoutList()[index].name;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Workout Name'),
          content: TextField(
            controller: newWorkoutNameController,
            decoration: InputDecoration(hintText: "Enter new workout name"),
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
                if (newWorkoutNameController.text.isNotEmpty) {
                  updateWorkoutName(index, newWorkoutNameController.text.trim());
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
            ),
          ],
        );
      },
    );
  }

  void save() {
    String newWorkoutName = newWorkoutNameController.text;
    if (newWorkoutName.isNotEmpty) {
      Provider.of<WorkoutRecord>(context, listen: false).addWorkout(newWorkoutName);
      Navigator.pop(context);
      clear();
    }
  }

  void updateWorkoutName(int index, String newName) {
    Provider.of<WorkoutRecord>(context, listen: false).updateWorkoutName(index, newName);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newWorkoutNameController.clear();
  }

  void goToWorkoutPage(String workoutName) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WorkoutPage(workoutName: workoutName)),
    );
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
          itemBuilder: (context, index) {
            final workout = value.getWorkoutList()[index];
            return ListTile(
              title: Text(workout.name),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => editWorkoutName(index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () => goToWorkoutPage(workout.name),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
