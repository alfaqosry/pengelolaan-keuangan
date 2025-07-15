import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:keuangan/app/controllers/auth_controller.dart';
import 'package:keuangan/app/routes/app_pages.dart';
import 'package:keuangan/app/utils/exericase_tile.dart';
import '../controllers/home_controller.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFAEC6CF),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: Color(0xFF8FAEBB),
        foregroundColor: Colors.white,
        children: [
          SpeedDialChild(
            child: Icon(Icons.add_circle, color: Colors.green),
            backgroundColor: Colors.white,
            label: 'Tambah Pendapatan',
            labelStyle: TextStyle(fontSize: 16.0),
            onTap: () => Get.toNamed(Routes.CREATE_PENDAPATAN),
          ),
          SpeedDialChild(
            child: Icon(Icons.remove_circle, color: Colors.red),
            backgroundColor: Colors.white,
            label: 'Tambah Pengeluaran',
            labelStyle: TextStyle(fontSize: 16.0),
            onTap: () => Get.toNamed(Routes.CREATE_PENGELUARAN),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(backgroundColor: Colors.white),
                  SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        final user = controller.namaUser.value;
                        final nama = user ?? 'Pengguna';
                        return Text(
                          "Hi, $nama",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }),
                      Text(
                        "Selamat Pagi",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF2F4F4F),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () => authC.logout(),
                    icon: Icon(Icons.logout, color: Colors.white),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  buildSummaryCard(
                    title: "Pemasukan",
                    color: Colors.green,
                    value: controller.totalPemasukan,
                  ),
                  SizedBox(width: 16),
                  buildSummaryCard(
                    title: "Pengeluaran",
                    color: Colors.red,
                    value: controller.totalPengeluaran,
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "Selisih",
                              style: TextStyle(
                                color: Colors.blue[600],
                                fontSize: 10,
                              ),
                            ),
                            SizedBox(height: 10),
                            Obx(
                              () =>
                                  Text("Rp ${formatJT(controller.saldoAkhir)}"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.grey[100],
                ),
                padding: EdgeInsets.all(25),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Transaksi",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 12),
                        Obx(
                          () => SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: ['Semua', 'Pemasukan', 'Pengeluaran']
                                  .map(
                                    (filter) => Padding(
                                      padding: const EdgeInsets.only(
                                        right: 8.0,
                                      ),
                                      child: ChoiceChip(
                                        label: Text(filter),
                                        selected:
                                            controller.selectedFilter.value ==
                                            filter,
                                        onSelected: (selected) {
                                          if (selected) {
                                            controller.selectedFilter.value =
                                                filter;
                                          }
                                        },
                                        selectedColor: Color(0xFF8FAEBB),
                                        backgroundColor: Colors.grey[200],
                                        labelStyle: TextStyle(
                                          color:
                                              controller.selectedFilter.value ==
                                                  filter
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    /// List Transaksi atau Kosong
                    Obx(
                      () => Expanded(
                        child: controller.isLoading.value
                            ? ListView.builder(
                                itemCount: 5,
                                itemBuilder: (context, index) => shimmerTile(),
                              )
                            : controller.filteredData.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.receipt_long,
                                    size: 60,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    "Transaksi tidak ada",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              )
                            : ListView.builder(
                                itemCount: controller.filteredData.length,
                                itemBuilder: (context, index) {
                                  final item = controller.filteredData[index];
                                  final tanggal =
                                      (item['tanggal_jam'] as Timestamp)
                                          .toDate();
                                  final isPemasukan =
                                      item['jenis'] == 'pemasukan';
                                  final jumlah = (item['jumlah'] ?? 0) as num;
                                  final formattedDate = DateFormat(
                                    'dd MMM yyyy, HH:mm',
                                  ).format(tanggal);

                                  return ExericaseTile(
                                    icon: isPemasukan
                                        ? Icons.arrow_downward
                                        : Icons.arrow_upward,
                                    iconColor: isPemasukan
                                        ? Colors.green
                                        : Colors.red,
                                    textColor: isPemasukan
                                        ? Colors.green
                                        : Colors.red,
                                    exerciseName: item['sumber'] ?? "-",
                                    numberOfExercises:
                                        "${NumberFormat('#,##0', 'id_ID').format(jumlah)}",
                                    tanggalJamKecil: formattedDate,
                                    kategori: item['kategori'],
                                  );
                                },
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget shimmerTile() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget buildSummaryCard({
    required String title,
    required Color color,
    required RxInt value,
  }) {
    return Expanded(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(title, style: TextStyle(color: color, fontSize: 10)),
              SizedBox(height: 10),
              Obx(() => Text("Rp ${formatJT(value.value)}")),
            ],
          ),
        ),
      ),
    );
  }

  String formatJT(int angka) {
    if (angka >= 1000000) {
      final jt = (angka / 1000000);
      return '${jt.toStringAsFixed(jt.truncateToDouble() == jt ? 0 : 1)} JT';
    } else {
      return NumberFormat('#,##0', 'id_ID').format(angka);
    }
  }
}
