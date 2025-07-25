import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends GetxController {
  final namaUser = ''.obs;
  final isLoading = true.obs;
  final user = Rxn<User>();
  final semuaData = <Map<String, dynamic>>[].obs;
  final daftarPemasukan = <Map<String, dynamic>>[].obs;
  final totalPemasukan = 0.obs;
  final totalPengeluaran = 0.obs;
  int get saldoAkhir => totalPemasukan.value - totalPengeluaran.value;
  var selectedFilter = 'Semua'.obs;
  List<Map<String, dynamic>> get filteredData {
    if (selectedFilter.value == 'Semua') {
      return semuaData;
    }
    return semuaData
        .where((e) => e['jenis'] == selectedFilter.value.toLowerCase())
        .toList();
  }

  void ambilNamaDariFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (doc.exists && doc.data() != null) {
      namaUser.value = doc.data()!['displayName'] ?? '';
    }
  }

  /// Mengambil semua data keuangan dari Firestore dan hitung total
  void ambilDataKeuangan() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('keuangan')
        .orderBy('tanggal_jam', descending: true)
        .snapshots()
        .listen((snapshot) {
          final semuaDocs = snapshot.docs.map((doc) => doc.data()).toList();

          final pemasukan = semuaDocs
              .where(
                (item) =>
                    (item['jenis'] ?? '').toString().toLowerCase() ==
                    'pemasukan',
              )
              .toList();

          final pengeluaran = semuaDocs
              .where(
                (item) =>
                    (item['jenis'] ?? '').toString().toLowerCase() ==
                    'pengeluaran',
              )
              .toList();

          // Hitung total pemasukan
          totalPemasukan.value = pemasukan.fold<int>(
            0,
            (sum, item) => sum + ((item['jumlah'] ?? 0) as num).toInt(),
          );

          // Hitung total pengeluaran
          totalPengeluaran.value = pengeluaran.fold<int>(
            0,
            (sum, item) => sum + ((item['jumlah'] ?? 0) as num).toInt(),
          );

          // Gabungkan semua data dan urutkan berdasarkan tanggal terbaru
          final gabungSemua = [...pemasukan, ...pengeluaran];
          gabungSemua.sort((a, b) {
            final tglA = (a['tanggal_jam'] as Timestamp).toDate();
            final tglB = (b['tanggal_jam'] as Timestamp).toDate();
            return tglB.compareTo(tglA);
          });

          semuaData.value = gabungSemua;
          daftarPemasukan.value = pemasukan; // jika ingin tampil terpisah
          isLoading.value = false;
        });
  }

  @override
  void onInit() {
    super.onInit();

    // Simpan user login pertama kali
    user.value = FirebaseAuth.instance.currentUser;

    // Dengarkan perubahan user login
    FirebaseAuth.instance.authStateChanges().listen((u) {
      user.value = u;
      if (u != null) ambilNamaDariFirestore();
    });

    // Ambil data keuangan dari Firestore
    ambilDataKeuangan();
  }
}
