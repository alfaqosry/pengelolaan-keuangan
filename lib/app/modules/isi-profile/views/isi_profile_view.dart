import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:keuangan/app/controllers/auth_controller.dart';

import '../controllers/isi_profile_controller.dart';

class IsiProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: WizardPertanyaanPage());
  }
}

class Pertanyaan {
  final String teks;
  final String? pertanyaanTambahan;

  Pertanyaan({required this.teks, this.pertanyaanTambahan});

  bool get punyaPertanyaanTambahan => pertanyaanTambahan != null;
}

class WizardPertanyaanPage extends StatefulWidget {
  @override
  State<WizardPertanyaanPage> createState() => _WizardPertanyaanPageState();
}

class _WizardPertanyaanPageState extends State<WizardPertanyaanPage> {
  int currentIndex = 0;

  final List<Pertanyaan> pertanyaanList = [
    Pertanyaan(
      teks: 'Apakah kamu tinggal di kos?',
      pertanyaanTambahan: 'Berapa biaya kos Anda per bulan?',
    ),
    Pertanyaan(
      teks: 'Apakah kamu bekerja sambil kuliah?',
      pertanyaanTambahan: 'Berapa penghasilan Anda per bulan?',
    ),
    Pertanyaan(teks: 'Apakah kamu menerima uang saku dari orang tua?'),
    Pertanyaan(teks: 'Apakah kamu memiliki tabungan pribadi?'),
  ];

  Map<int, bool?> jawabanYaTidak = {}; // jawaban Ya/Tidak
  Map<int, String?> jawabanTambahan = {}; // jawaban tambahan

  final TextEditingController inputTambahanController = TextEditingController();

  void next() {
    // simpan input tambahan jika perlu
    if (isJawabYaDanPerluIsiTambahan()) {
      jawabanTambahan[currentIndex] = inputTambahanController.text.trim();
      inputTambahanController.clear();
    }

    if (currentIndex < pertanyaanList.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      // Selesai
      print('Jawaban Ya/Tidak: $jawabanYaTidak');
      print('Jawaban Tambahan: $jawabanTambahan');
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Selesai!"),
          content: Text("Terima kasih sudah mengisi semua pertanyaan."),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Tutup"),
            ),
          ],
        ),
      );
    }
  }

  void back() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        inputTambahanController.text = jawabanTambahan[currentIndex] ?? '';
      });
    }
  }

  Widget buildOptionButton(String label, bool value) {
    bool isSelected = jawabanYaTidak[currentIndex] == value;
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            jawabanYaTidak[currentIndex] = value;
            if (!value) {
              inputTambahanController.clear();
              jawabanTambahan[currentIndex] = null;
            }
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
          foregroundColor: isSelected ? Colors.white : Colors.black,
          padding: EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(label),
      ),
    );
  }

  bool isJawabYaDanPerluIsiTambahan() {
    final pertanyaan = pertanyaanList[currentIndex];
    return jawabanYaTidak[currentIndex] == true &&
        pertanyaan.punyaPertanyaanTambahan;
  }

  bool isNextEnabled() {
    final jawab = jawabanYaTidak[currentIndex];
    if (jawab == null) return false;

    // Kalau tidak ada pertanyaan tambahan atau jawabnya TIDAK, bisa lanjut
    if (!isJawabYaDanPerluIsiTambahan()) return true;

    // Kalau ada pertanyaan tambahan dan jawabannya YA, pastikan sudah isi
    return inputTambahanController.text.trim().isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final pertanyaan = pertanyaanList[currentIndex];
    bool isLast = currentIndex == pertanyaanList.length - 1;
    bool isYa = jawabanYaTidak[currentIndex] == true;

    return Scaffold(
      appBar: AppBar(title: Text('Wizard Pertanyaan')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              'Pertanyaan ${currentIndex + 1} dari ${pertanyaanList.length}',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Text(
              pertanyaan.teks,
              style: TextStyle(fontSize: 22),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),

            Row(
              children: [
                buildOptionButton("Ya", true),
                SizedBox(width: 10),
                buildOptionButton("Tidak", false),
              ],
            ),

            if (isJawabYaDanPerluIsiTambahan()) ...[
              SizedBox(height: 20),
              TextField(
                controller: inputTambahanController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: pertanyaan.pertanyaanTambahan!,
                  border: OutlineInputBorder(),
                ),
              ),
            ],

            Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: currentIndex > 0 ? back : null,
                  child: Text('Back'),
                ),
                ElevatedButton(
                  onPressed: isNextEnabled() ? next : null,
                  child: Text(isLast ? 'Selesai' : 'Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
