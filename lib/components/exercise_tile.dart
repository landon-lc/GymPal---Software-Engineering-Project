import 'package:flutter/material.dart';

class ExerciseTile extends StatelessWidget {
  final String exerciseName;
  final String weight;
  final String reps;
  final String sets;
  final bool isCompleted;
  final void Function(bool?) onCheckBoxChanged;

  const ExerciseTile({
    Key? key,
    required this.exerciseName,
    required this.weight,
    required this.reps,
    required this.sets,
    required this.isCompleted,
    required this.onCheckBoxChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200], // Slight adjustment for better UI
      child: ListTile(
        title: Text(exerciseName),
        subtitle: Row(
          children: [
            Chip(label: Text('$weight lbs')),
            SizedBox(width: 4), // Added for spacing
            Chip(label: Text('$reps reps')),
            SizedBox(width: 4), // Added for spacing
            Chip(label: Text('$sets sets')),
          ],
        ),
        trailing: Checkbox(
          value: isCompleted,
          onChanged: onCheckBoxChanged,
        ),
      ),
    );
  }
}
