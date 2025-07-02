import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/create_pengeluaran_controller.dart';

class CreatePengeluaranView extends GetView<CreatePengeluaranController> {
  const CreatePengeluaranView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CreatePengeluaranView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CreatePengeluaranView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
