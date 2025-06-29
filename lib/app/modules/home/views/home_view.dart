import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:keuangan/app/controllers/auth_controller.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.all(16),
              child: Row(
                children: [
                  CircleAvatar(backgroundColor: Colors.red),
                  SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Halo Adam",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        "Selamat Pagi",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () => authC.logout(),
                    icon: Icon(Icons.logout),
                  ),
                ],
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
