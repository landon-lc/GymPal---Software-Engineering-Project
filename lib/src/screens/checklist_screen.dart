import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:test_drive/src/models/workout_record.dart';
import 'package:test_drive/src/models/workout.dart';
import 'package:test_drive/src/screens/workout_screen.dart'; 
import 'package:intl/intl.dart';


class ChecklistPage extends StatefulWidget {
  const ChecklistPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChecklistPageState createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  final TextEditingController _controller = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  void _showDatePicker() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
      initialDateRange: startDate != null && endDate != null
          ? DateTimeRange(start: startDate!, end: endDate!)
          : null,
    );

    if (picked != null) {
      setState(() {
        startDate = picked.start;
        endDate = picked.end;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Tracker'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: _showDatePicker,
          ),
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () {
              setState(() {
                startDate = null;
                endDate = null;
              });
            },    
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewWorkout,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<Workout>>(
        stream: Provider.of<WorkoutRecord>(context).workoutsStream(start: startDate, end: endDate),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No workouts found'));
          }
          final workouts = snapshot.data!;

          Text(
            startDate != null && endDate != null
                ? 'Showing workouts from ${DateFormat('MM/dd/yyyy').format(startDate!)} to ${DateFormat('MM/dd/yyyy').format(endDate!)}'
                : 'Showing All Workouts',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
          );

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
                      onPressed: (context) => _editWorkout(workout.key),
                      backgroundColor: Colors.blue,
                      icon: Icons.edit,
                      label: 'Edit',
                    ),
                    SlidableAction(
                      onPressed: (context) {
                        if (workout.key != null) {
                          Provider.of<WorkoutRecord>(context, listen: false).deleteWorkout(workout.key!);
                        }
                      },
                      backgroundColor: Colors.red,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(workout.name),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => WorkoutPage(
                        workoutId: workout.key ?? '',
                        workoutName: workout.name,
                      ),
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

  void _createNewWorkout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create a new workout'),
        content: TextField(controller: _controller),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final name = _controller.text.trim();
              if (name.isNotEmpty) {
                Provider.of<WorkoutRecord>(context, listen: false).addWorkout(name);
                _controller.clear();
                Navigator.pop(context);
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
}