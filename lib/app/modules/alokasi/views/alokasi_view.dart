// lib/app/modules/alokasi/views/alokasi_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:keuangan/app/models/alokasi_dana_model.dart';
import 'package:keuangan/app/routes/app_pages.dart';
import '../controllers/alokasi_controller.dart';

class AlokasiView extends GetView<AlokasiController> {
  const AlokasiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alokasi Dana"),
        centerTitle: true,
        backgroundColor: const Color(0xFFAEC6CF),
        foregroundColor: const Color(0xFF333333),
      ),
      body: Obx(
        () => controller.alokasiList.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.account_balance_wallet_outlined,
                      size: 60,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Belum ada data alokasi",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.alokasiList.length,
                itemBuilder: (context, index) {
                  final data = controller.alokasiList[index];
                  return buildAlokasiTile(data);
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.CREATE_ALOKASI),
        backgroundColor: const Color(0xFFAEC6CF),
        foregroundColor: const Color(0xFF333333),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildAlokasiTile(AlokasiDanaModel data) {
    final now = DateTime.now();
    final bulanAwal = DateTime(now.year, now.month, 1);
    final bulanAkhir = DateTime(now.year, now.month + 1, 0, 23, 59, 59);

    return FutureBuilder<int>(
      future: controller.hitungPengeluaranPerKategori(
        data.nama,
        bulanAwal,
        bulanAkhir,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Card(
            margin: EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: LinearProgressIndicator(),
            ),
          );
        }

        final pengeluaran = snapshot.data ?? 0;
        final persen = data.alokasi > 0 ? pengeluaran / data.alokasi : 0.0;
        final overBudget = persen > 1;

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.nama,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: overBudget ? Colors.red : Colors.black,
                  ),
                ),
                const SizedBox(height: 6),
                LinearProgressIndicator(
                  value: persen > 1 ? 1 : persen,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    overBudget ? Colors.red : Colors.green,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Pengeluaran: Rp ${NumberFormat('#,##0', 'id_ID').format(pengeluaran)}"
                  " / Rp ${NumberFormat('#,##0', 'id_ID').format(data.alokasi)}",
                  style: TextStyle(
                    color: overBudget ? Colors.red : Colors.black54,
                  ),
                ),
                if (overBudget)
                  const Text(
                    "⚠️ Pengeluaran melebihi batas!",
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
