import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:test_drive/data/workout_record.dart';
import 'package:test_drive/models/workout.dart';
import 'workout_page.dart'; // Adjust the import path as needed

class ChecklistPage extends StatefulWidget {
  const ChecklistPage({Key? key}) : super(key: key); // Updated for null safety

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
        content: TextField(controller: newWorkoutNameController),
        actions: [
          TextButton(
            onPressed: () {
              final name = newWorkoutNameController.text.trim();
              if (name.isNotEmpty) {
                Provider.of<WorkoutRecord>(context, listen: false).addWorkout(name);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Save'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Workout Tracker')),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewWorkout,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<Workout>>(
        stream: Provider.of<WorkoutRecord>(context).workoutsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No workouts found'));
          }
          final workouts = snapshot.data!;
          return ListView.builder(
            itemCount: workouts.length,
            itemBuilder: (context, index) {
              final workout = workouts[index];
              return Slidable(
                key: ValueKey(workout.key), // Use the workout's Firebase key as the ValueKey
                startActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (BuildContext context) {
                        // Handle edit workout action
                      },
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
                        // Handle delete workout action
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
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WorkoutPage(workoutName: workout.name, workoutId: workout.key ?? ''), // Pass the workoutId here
                    ),
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
