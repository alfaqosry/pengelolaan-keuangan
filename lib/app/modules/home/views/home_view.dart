import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:keuangan/app/controllers/auth_controller.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () => authC.logout(), icon: Icon(Icons.logout)),
        ],
      ),
      body: Center(
        child: Obx(() {
          final user = controller.namaUser.value;
          final nama = user ?? 'Pengguna';

          return Text('Selamat datang, $nama', style: TextStyle(fontSize: 20));
        }),
      ),
    );
  }
}
