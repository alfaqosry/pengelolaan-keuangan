import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keuangan/app/models/alokasi_dana_model.dart';

class CreateAlokasiController extends GetxController {
  // Controller untuk form input
  final namaC = TextEditingController();
  final jumlahC = TextEditingController();

  // Switch prioritas
  final isPrioritas = false.obs;

  /// Fungsi menyimpan alokasi ke Firestore
  Future<void> simpanAlokasi() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      Get.snackbar("Gagal", "User belum login");
      return;
    }

    try {
      final jumlah = int.tryParse(jumlahC.text);
      if (jumlah == null || jumlah <= 0) {
        Get.snackbar("Error", "Jumlah tidak valid");
        return;
      }

      final data = AlokasiDanaModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        nama: namaC.text.trim(),
        alokasi: jumlah,
        pengeluaran: 0,
        prioritas: isPrioritas.value,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('alokasi')
          .doc(data.id)
          .set(data.toJson());

      // Tambahkan delay singkat untuk memastikan listener berjalan
      await Future.delayed(const Duration(milliseconds: 300));

      Get.back(); // Kembali ke halaman sebelumnya
      Get.snackbar("Sukses", "Data alokasi berhasil disimpan");
    } catch (e) {
      Get.snackbar("Gagal", "Terjadi kesalahan: $e");
    }
  }

  @override
  void onClose() {
    namaC.dispose();
    jumlahC.dispose();
    super.onClose();
  }
}
