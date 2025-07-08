import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/create_pendapatan_controller.dart';

class CreatePendapatanView extends GetView<CreatePendapatanController> {
  const CreatePendapatanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Pemasukan'),
        backgroundColor: const Color(0xFFAEC6CF),
        foregroundColor: const Color(0xFF333333),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => InkWell(
                              onTap: () => controller.pickTanggal(context),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: "Tanggal",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    DateFormat(
                                      'dd MMM yyyy',
                                    ).format(controller.tanggal.value),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Obx(
                            () => InkWell(
                              onTap: () => controller.pickTime(context),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: "Jam",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(controller.formattedTime),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    TextFormField(
                      controller: controller.sumberC,
                      decoration: InputDecoration(
                        labelText: "Sumber Pemasukan",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    TextFormField(
                      controller: controller.jumlahC,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Jumlah",
                        hintText: "Mis 1000.000",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    SizedBox(height: 12),
                    TextFormField(
                      controller: controller.keteranganC,
                      decoration: InputDecoration(
                        labelText: "Keterangan",
                        hintText: "Keterangan (tidak wajib diisi)",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.simpanPendapatan();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: const Color(0xFFAEC6CF),
                    foregroundColor: const Color(0xFF333333),
                  ),
                  child: const Text("Simpan", style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
