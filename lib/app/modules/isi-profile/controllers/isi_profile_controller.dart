import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:keuangan/app/controllers/navigation_controller.dart';
import 'package:keuangan/app/routes/app_pages.dart';
import 'package:keuangan/app/widgets/main_navigation.dart';
import 'package:keuangan/main.dart';

class IsiProfileController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final navC = Get.find<NavigationController>();
  final pertanyaanList = [
    {
      'teks': 'Apakah kamu tinggal di kos?',
      'tambahan': 'Berapa biaya kos Anda per bulan?',
    },
    {
      'teks': 'Apakah kamu bekerja sambil kuliah?',
      'tambahan': 'Berapa penghasilan Anda per bulan?',
    },
    {'teks': 'Apakah kamu menerima uang saku dari orang tua?'},
    {'teks': 'Apakah kamu memiliki tabungan pribadi?'},
  ];

  final jawabanYaTidak = <int, bool?>{}.obs;
  final jawabanTambahan = <int, String?>{}.obs;

  void simpanJawabanKeFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Get.snackbar("Error", "User belum login.");
      return;
    }

    final yaTidakMap = jawabanYaTidak.map((k, v) => MapEntry(k.toString(), v));
    final tambahanMap = jawabanTambahan.map(
      (k, v) => MapEntry(k.toString(), v),
    );

    print("DATA DISIMPAN:");
    print("Ya/Tidak: $yaTidakMap");
    print("Tambahan: $tambahanMap");

    try {
      final result = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('jawaban_user')
          .add({
            'uid': user.uid,
            'email': user.email,
            'yaTidak': jawabanYaTidak.map((k, v) => MapEntry(k.toString(), v)),
            'tambahan': jawabanTambahan.map(
              (k, v) => MapEntry(k.toString(), v),
            ),
            'created_at': DateTime.now(),
          });

      print("Sukses simpan ke ID: ${result.id}");

      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Data berhasil disimpan ke Firestore!",
        confirm: ElevatedButton(
          onPressed: () {
            Get.back(); // Tutup dialog
            Get.offAll(() => MyApp());
          },
          child: Text("Oke"),
        ),
      );
    } catch (e) {
      Get.snackbar("Error", "Gagal simpan: $e");
    }
  }
}
