import 'package:flutter/material.dart';

class ExericaseTile extends StatelessWidget {
  final icon;
  final String exerciseName;
  final String numberOfExercises;
  final Color iconColor;
  final Color textColor;
  final String tanggalJamKecil;

  const ExericaseTile({
    super.key,
    required this.icon,
    required this.exerciseName,
    required this.numberOfExercises,
    required this.iconColor,
    required this.textColor,
    required this.tanggalJamKecil,
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
          iconColor: iconColor,
          title: Text(exerciseName),
          subtitle: Text(
            'Rp. ' + numberOfExercises,
            style: TextStyle(color: textColor),
          ),
          trailing: Text(
            tanggalJamKecil,
            style: TextStyle(fontSize: 11, color: Colors.grey[600]),
            textAlign: TextAlign.end,
          ),
        ),
      ),
    );
  }
}
