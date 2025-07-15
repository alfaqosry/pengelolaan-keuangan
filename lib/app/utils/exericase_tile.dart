import 'package:flutter/material.dart';

class ExericaseTile extends StatelessWidget {
  final icon;
  final String exerciseName;
  final String numberOfExercises;
  final Color iconColor;
  final Color textColor;
  final String tanggalJamKecil;
  final String kategori;

  const ExericaseTile({
    super.key,
    required this.icon,
    required this.exerciseName,
    required this.numberOfExercises,
    required this.iconColor,
    required this.textColor,
    required this.tanggalJamKecil,
    required this.kategori,
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
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                kategori,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.end,
              ),
              Text(
                tanggalJamKecil,
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
