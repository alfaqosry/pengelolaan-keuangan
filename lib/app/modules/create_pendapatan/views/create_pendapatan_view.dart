import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:keuangan/app/widgets/tombol_kateogori.dart';
import '../controllers/create_pendapatan_controller.dart';

class CreatePendapatanView extends GetView<CreatePendapatanController> {
  const CreatePendapatanView({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Tambah Pemasukan'),
        backgroundColor: const Color(0xFFAEC6CF),
        foregroundColor: const Color(0xFF333333),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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

                // TextField Sumber Pemasukan
                TextFormField(
                  controller: controller.sumberC,
                  decoration: InputDecoration(
                    labelText: "Sumber Pemasukan",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Sumber pemasukan tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    TombolKategori(
                      kategoriTombol: "Gaji Bulanan",
                      onTap: () => controller.sumberC.text = "Gaji Bulanan",
                    ),
                    const SizedBox(width: 8),
                    TombolKategori(
                      kategoriTombol: "Uang Saku",
                      onTap: () => controller.sumberC.text = "Uang Saku",
                    ),
                    const SizedBox(width: 8),
                    TombolKategori(
                      kategoriTombol: "Jualan",
                      onTap: () => controller.sumberC.text = "Jualan",
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                TextFormField(
                  controller: controller.kategoriC,
                  decoration: InputDecoration(
                    labelText: "Kategori",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Kategori pemasukan tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    TombolKategori(
                      kategoriTombol: "Gaji Bulanan",
                      onTap: () => controller.kategoriC.text = "Gaji Bulanan",
                    ),
                    TombolKategori(
                      kategoriTombol: "Uang Saku",
                      onTap: () => controller.kategoriC.text = "Uang Saku",
                    ),
                    TombolKategori(
                      kategoriTombol: "Freelance",
                      onTap: () => controller.kategoriC.text = "Freelance",
                    ),
                    TombolKategori(
                      kategoriTombol: "Sampingan",
                      onTap: () => controller.kategoriC.text = "Sampingan",
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                TextFormField(
                  controller: controller.jumlahC,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Jumlah",
                    hintText: "Mis. 1000000",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Jumlah tidak boleh kosong';
                    }
                    final numValue = num.tryParse(value);
                    if (numValue == null || numValue <= 0) {
                      return 'Masukkan jumlah yang valid';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 12),
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

                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.simpanPendapatan();
                      }
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
      ),
    );
  }
}
