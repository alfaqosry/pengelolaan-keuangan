import 'package:flutter/material.dart';

class ExericaseTile extends StatelessWidget {
  final icon;
  final String exerciseName;
  final String numberOfExercises;
  const ExericaseTile({
    super.key,
    required this.icon,
    required this.exerciseName,
    required this.numberOfExercises,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          leading: Icon(icon),
          title: Text(exerciseName),
          subtitle: Text(
            'Rp. ' + numberOfExercises,
            style: TextStyle(color: Colors.green),
          ),
        ),
      ),
    );
  }
}
