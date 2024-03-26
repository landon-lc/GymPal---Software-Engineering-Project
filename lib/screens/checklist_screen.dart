import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:test_drive/data/workout_record.dart';
import 'package:test_drive/models/workout.dart';
import 'workout_screen.dart';

class ChecklistPage extends StatefulWidget {
  const ChecklistPage({super.key});

  @override
  State<ChecklistPage> createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  final TextEditingController _controller = TextEditingController();

  void _createNewWorkout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create a new workout'),
        content: TextField(controller: _controller),
        actions: [
          TextButton(
            onPressed: () => 
              Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final name = _controller.text.trim();
              if (name.isNotEmpty) {
                Provider.of<WorkoutRecord>(context, listen: false).addWorkout(name);
                // Need to handle workout id. 
                Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutPage(workoutName: _controller.text, workoutId: '1')));
                _controller.clear();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _editWorkout(String? workoutKey) {
    if (workoutKey == null) return;
    final TextEditingController editController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit workout name'),
        content: TextField(
          controller: editController,
          decoration: const InputDecoration(hintText: 'Enter new workout name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final newName = editController.text.trim();
              if (newName.isNotEmpty) {
                Provider.of<WorkoutRecord>(context, listen: false).editWorkout(workoutKey, newName);
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
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
        onPressed: _createNewWorkout,
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
                key: ValueKey(workout.key),
                startActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (BuildContext context) => _editWorkout(workout.key),
                      backgroundColor: Colors.blue,
                      icon: Icons.edit,
                      label: 'Edit',
                    ),
                    SlidableAction(
                      onPressed: (BuildContext context) {
                        Provider.of<WorkoutRecord>(context, listen: false).deleteWorkout(workout.key ?? '');
                      },
                      backgroundColor: Colors.red,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(workout.name),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => WorkoutPage(workoutId: workout.key ?? '', workoutName: workout.name),
                    ));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}


// NOTE - Original code in main. May be fine to delete, leaving in case not. 

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:test_drive/data/workout_record.dart';
// import 'workout_screen.dart'; // Make sure the import path is correct

// class ChecklistScreen extends StatefulWidget {
//   const ChecklistScreen({super.key});

//   @override
//   State<ChecklistScreen> createState() => _ChecklistScreenState();
// }

// class _ChecklistScreenState extends State<ChecklistScreen> {
//   final TextEditingController newWorkoutNameController =
//       TextEditingController();

//   void createNewWorkout() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Create a new workout'),
//         content: TextField(
//           controller: newWorkoutNameController,
//         ),
//         actions: [
//           MaterialButton(
//             onPressed: save,
//             child: const Text('Save'),
//           ),
//           MaterialButton(
//             onPressed: cancel,
//             child: const Text('Cancel'),
//           ),
//         ],
//       ),
//     );
//   }

//   void goToWorkoutPage(String workoutName) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => WorkoutScreen(workoutName: workoutName),
//       ),
//     );
//   }

//   void save() {
//     String newWorkoutName = newWorkoutNameController.text;
//     if (newWorkoutName.isNotEmpty) {
//       Provider.of<WorkoutRecord>(context, listen: false)
//           .addWorkout(newWorkoutName);
//       Navigator.pop(context); // Close the dialog
//       clear();
//     }
//   }

//   void cancel() {
//     Navigator.pop(context); // Close the dialog
//     clear();
//   }

//   void clear() {
//     newWorkoutNameController.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<WorkoutRecord>(
//       builder: (context, value, child) => Scaffold(
//         appBar: AppBar(
//           title: const Text('Workout Tracker'),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: createNewWorkout,
//           child: const Icon(Icons.add),
//         ),
//         body: ListView.builder(
//           itemCount: value.getWorkoutList().length,
//           itemBuilder: (context, index) => ListTile(
//             title: Text(value.getWorkoutList()[index].name),
//             trailing: IconButton(
//               icon: const Icon(Icons.arrow_forward_ios),
//               onPressed: () =>
//                   goToWorkoutPage(value.getWorkoutList()[index].name),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }