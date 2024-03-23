import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_drive/data/workout_record.dart';
import 'package:test_drive/models/workout.dart';
import 'workout_page.dart'; 

class ChecklistPage extends StatefulWidget {
  const ChecklistPage({Key? key}) : super(key: key);

  @override
  _ChecklistPageState createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  final TextEditingController _controller = TextEditingController();

  void _createNewWorkout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Create a new workout'),
        content: TextField(controller: _controller),
        actions: [
          TextButton(
            onPressed: () {
              final name = _controller.text.trim();
              if (name.isNotEmpty) {
                Provider.of<WorkoutRecord>(context, listen: false).addWorkout(name);
                Navigator.pop(context);
                _controller.clear();
              }
            },
            child: Text('Save'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Workout Tracker')),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewWorkout,
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<List<Workout>>(
        stream: Provider.of<WorkoutRecord>(context).workoutsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No workouts found'));
          }
          final workouts = snapshot.data!;
          return ListView.builder(
            itemCount: workouts.length,
            itemBuilder: (context, index) {
              final workout = workouts[index];
              return ListTile(
                title: Text(workout.name),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WorkoutPage(workoutId: workout.key ?? '', workoutName: workout.name)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
