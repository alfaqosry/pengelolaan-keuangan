import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:keuangan/app/controllers/auth_controller.dart';

import '../controllers/isi_profile_controller.dart';

class IsiProfileView extends GetView<IsiProfileController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(onPressed: () => authC.logout(), icon: Icon(Icons.logout)),
        ],
      ),
      body: const Center(
        child: Text(
          'IsiProfileView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
