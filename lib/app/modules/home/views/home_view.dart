import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:keuangan/app/controllers/auth_controller.dart';
import 'package:keuangan/app/routes/app_pages.dart';
import 'package:keuangan/app/utils/exericase_tile.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFAEC6CF),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        children: [
          SpeedDialChild(
            child: Icon(Icons.add_circle, color: Colors.green),
            backgroundColor: Colors.white,
            label: 'Tambah Pendapatan',
            labelStyle: TextStyle(fontSize: 16.0),
            onTap: () {
              Get.toNamed(Routes.CREATE_PENDAPATAN);
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.remove_circle, color: Colors.red),
            backgroundColor: Colors.white,
            label: 'Tambah Pengeluaran',
            labelStyle: TextStyle(fontSize: 16.0),
            onTap: () {
              Get.toNamed(Routes.CREATE_PENGELUARAN);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.all(16),
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
                          "Hi,  $nama",
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
                              "Pemasukan",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 10,
                              ),
                            ),
                            SizedBox(height: 10),
                            Obx(
                              () => Text(
                                "Rp ${NumberFormat('#,##0', 'id_ID').format(controller.totalPemasukan.value)}",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16), // jarak antar card
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
                              "Pengeluaran",
                              style: TextStyle(color: Colors.red, fontSize: 10),
                            ),
                            SizedBox(height: 10),
                            Obx(
                              () => Text(
                                "Rp ${NumberFormat('#,##0', 'id_ID').format(controller.totalPengeluaran.value)}",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
                              () => Text(
                                "Rp ${NumberFormat('#,##0', 'id_ID').format(controller.saldoAkhir)}",
                              ),
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
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Transaksi",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Icon(Icons.more_horiz),
                        ],
                      ),

                      SizedBox(height: 20),
                      Obx(
                        () => Expanded(
                          child: ListView.builder(
                            itemCount: controller.semuaData.length,

                            itemBuilder: (context, index) {
                              final item = controller.semuaData[index];
                              final tanggal = (item['tanggal_jam'] as Timestamp)
                                  .toDate();
                              final isPemasukan = item['jenis'] == 'pemasukan';
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
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // body: Center(
      //   child: Obx(() {
      //     final user = controller.namaUser.value;
      //     final nama = user ?? 'Pengguna';

      //     return Text('Selamat datang, $nama', style: TextStyle(fontSize: 20));
      //   }),
    );
  }
}
