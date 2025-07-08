import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CreatePendapatanController extends GetxController {
  //TODO: Implement CreatePendapatanController

  TextEditingController jumlahC = TextEditingController();
  TextEditingController sumberC = TextEditingController();
  TextEditingController keteranganC = TextEditingController();

  var selectedTime = TimeOfDay.now().obs;
  var tanggal = DateTime.now().obs;

  Future<void> pickTanggal(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: tanggal.value,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != tanggal.value) {
      tanggal.value = picked;
    }
  }

  Future<void> pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
    );

    if (picked != null) {
      selectedTime.value = picked;
    }
  }

  String get formattedTime {
    final time = selectedTime.value;
    final now = DateTime.now();
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

  // Gabungkan Tanggal + Jam
  DateTime get fullDateTime {
    final t = tanggal.value;
    final jam = selectedTime.value;
    return DateTime(t.year, t.month, t.day, jam.hour, jam.minute);
  }

  Future<void> simpanPendapatan() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      Get.snackbar("Gagal", "User belum login");
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('keuangan')
          .add({
            'jenis': 'pemasukan',
            'sumber': sumberC.text,
            'jumlah': int.parse(jumlahC.text),
            'tanggal_jam': Timestamp.fromDate(fullDateTime),
            'keterangan': keteranganC.text.isEmpty ? null : keteranganC.text,
            'created_at': FieldValue.serverTimestamp(),
          });

      Get.back();
      Get.snackbar("Sukses", "Data pemasukan berhasil disimpan");

      sumberC.clear();
      jumlahC.clear();
      keteranganC.clear();
    } catch (e) {
      Get.snackbar("Error", "Gagal menyimpan data: $e");
    }
  }
}
