import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:keuangan/app/controllers/auth_controller.dart';

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
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
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
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16), // jarak antar card
                  Expanded(
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
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
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Container(
                padding: EdgeInsets.all(25),
                color: Colors.grey[100],
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
