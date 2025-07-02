import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/create_pendapatan_controller.dart';

class CreatePendapatanView extends GetView<CreatePendapatanController> {
  const CreatePendapatanView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Pendapatan'),
        backgroundColor: Color(0xFFAEC6CF),
        foregroundColor: Color((0xFF333333)),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CreatePendapatanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
