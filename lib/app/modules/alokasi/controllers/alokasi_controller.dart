import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:keuangan/app/models/alokasi_dana_model.dart';

class AlokasiController extends GetxController {
  final alokasiList = <AlokasiDanaModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    listenToAlokasiRealtime(); // realtime listener
  }

  void listenToAlokasiRealtime() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('alokasi')
        .orderBy('prioritas', descending: true) // opsional sorting
        .snapshots()
        .listen((QuerySnapshot snapshot) {
          final data = snapshot.docs.map((doc) {
            return AlokasiDanaModel.fromJson(
              doc.data() as Map<String, dynamic>,
              doc.id,
            );
          }).toList();

          alokasiList.assignAll(data);
        });
  }

  /// Hitung total pengeluaran berdasarkan kategori (per bulan)
  Future<int> hitungPengeluaranPerKategori(
    String kategori,
    DateTime awal,
    DateTime akhir,
  ) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return 0;

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('keuangan')
        .where('jenis', isEqualTo: 'pengeluaran')
        .where('kategori', isEqualTo: kategori)
        .where('tanggal_jam', isGreaterThanOrEqualTo: awal)
        .where('tanggal_jam', isLessThanOrEqualTo: akhir)
        .get();

    int total = 0;
    for (var doc in snapshot.docs) {
      total += (doc['jumlah'] ?? 0) as int;
    }
    return total;
  }
}
