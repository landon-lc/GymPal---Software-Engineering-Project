import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:test_drive/data/workout_record.dart';
import 'workout_page.dart'; // Make sure this path is correct

class ChecklistPage extends StatefulWidget {
  // ignore: use_super_parameters
  const ChecklistPage({Key? key}) : super(key: key);

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
          TextButton(
            onPressed: save,
            child: const Text('Save'),
          ),
          TextButton(
            onPressed: cancel,
            child: const Text('Cancel'),
          ),
        ],
      ),
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

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newWorkoutNameController.clear();
  }

  void updateWorkoutName(int index, String newName) {
    Provider.of<WorkoutRecord>(context, listen: false).updateWorkoutName(index, newName);
    clear();
  }

  void editWorkoutName(int index) {
    newWorkoutNameController.text = Provider.of<WorkoutRecord>(context, listen: false).getWorkoutList()[index].name;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Workout Name'),
        content: TextField(
          controller: newWorkoutNameController,
          decoration: const InputDecoration(hintText: 'Enter new workout name'),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Save'),
            onPressed: () {
              if (newWorkoutNameController.text.isNotEmpty) {
                updateWorkoutName(index, newWorkoutNameController.text.trim());
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
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
      builder: (context, workoutRecord, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Workout Tracker'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewWorkout,
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: workoutRecord.getWorkoutList().length,
          itemBuilder: (context, index) {
            final workout = workoutRecord.getWorkoutList()[index];
            return Slidable(
              key: ValueKey(workout.name),
              startActionPane: ActionPane(
                motion: const DrawerMotion(),
                children: [
                  SlidableAction(
                    onPressed: (BuildContext context) => editWorkoutName(index),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Edit',
                  ),
                ],
              ),
              endActionPane: ActionPane(
                motion: const DrawerMotion(),
                children: [
                  SlidableAction(
                    onPressed: (BuildContext context) {
                      setState(() {
                        workoutRecord.workoutList.removeAt(index);
                      });
                      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                      workoutRecord.notifyListeners();
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),
              child: ListTile(
                title: Text(workout.name),
                onTap: () => goToWorkoutPage(workout.name),
              ),
            );
          },
        ),
      ),
    );
  }
}
