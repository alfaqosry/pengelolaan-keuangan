import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:keuangan/app/controllers/auth_controller.dart';
import 'package:keuangan/app/utils/exericase_tile.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFAEC6CF),
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
                        child: Text(
                          "Pemasukan",
                          style: TextStyle(color: Colors.green, fontSize: 10),
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
                        child: Text(
                          "Pengeluaran",
                          style: TextStyle(color: Colors.red, fontSize: 10),
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
                        child: Text(
                          "Selisih",
                          style: TextStyle(
                            color: Colors.blue[600],
                            fontSize: 10,
                          ),
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
                            "Statistik",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Icon(Icons.more_horiz),
                        ],
                      ),

                      SizedBox(height: 20),
                      Expanded(
                        child: ListView(
                          children: [
                            ExericaseTile(
                              icon: Icons.arrow_upward,
                              exerciseName: "Gaji Bulanan",
                              numberOfExercises: "1000.000",
                            ),
                            ExericaseTile(
                              icon: Icons.arrow_upward,
                              exerciseName: "Gaji Bulanan",
                              numberOfExercises: "1000.000",
                            ),
                          ],
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
