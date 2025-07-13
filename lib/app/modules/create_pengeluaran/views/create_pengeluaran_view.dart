import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:keuangan/app/widgets/tombol_kateogori.dart';
import '../controllers/create_pengeluaran_controller.dart';

class CreatePengeluaranView extends GetView<CreatePengeluaranController> {
  const CreatePengeluaranView({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Tambah Pengeluaran'),

        backgroundColor: const Color(0xFFAEC6CF),
        foregroundColor: const Color(0xFF333333),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
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

                    // Sumber Pengeluaran
                    TextFormField(
                      controller: controller.sumberC,
                      decoration: InputDecoration(
                        labelText: "Sumber Pengeluaran",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Sumber pengeluaran tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          TombolKategori(
                            kategoriTombol: "Makanan",
                            onTap: () => controller.sumberC.text = "Makanan",
                          ),
                          SizedBox(width: 8),
                          TombolKategori(
                            kategoriTombol: "Listrik",
                            onTap: () => controller.sumberC.text = "Listrik",
                          ),
                          SizedBox(width: 8),
                          TombolKategori(
                            kategoriTombol: "Belanja",
                            onTap: () => controller.sumberC.text = "Belanja",
                          ),
                          SizedBox(width: 8),
                          TombolKategori(
                            kategoriTombol: "Jajan",
                            onTap: () => controller.sumberC.text = "Jajan",
                          ),
                          SizedBox(width: 8),
                          TombolKategori(
                            kategoriTombol: "Bensin",
                            onTap: () => controller.sumberC.text = "Bensin",
                          ),
                          SizedBox(width: 8),
                          TombolKategori(
                            kategoriTombol: "Pulsa",
                            onTap: () => controller.sumberC.text = "Pulsa",
                          ),
                        ],
                      ),
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
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          TombolKategori(
                            kategoriTombol: "Makan dan Minum",
                            onTap: () =>
                                controller.kategoriC.text = "Makan dan Minum",
                          ),
                          SizedBox(width: 8),
                          TombolKategori(
                            kategoriTombol: "Jajan",
                            onTap: () => controller.kategoriC.text = "Jajan",
                          ),
                          SizedBox(width: 8),
                          TombolKategori(
                            kategoriTombol: "Belanja Bulanan",
                            onTap: () =>
                                controller.kategoriC.text = "Belanja Bulanan",
                          ),
                          SizedBox(width: 8),
                          TombolKategori(
                            kategoriTombol: "Pulsa",
                            onTap: () => controller.kategoriC.text = "Pulsa",
                          ),
                          SizedBox(width: 8),
                          TombolKategori(
                            kategoriTombol: "Transportasi",
                            onTap: () =>
                                controller.kategoriC.text = "Transportasi",
                          ),
                          SizedBox(width: 8),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Jumlah
                    TextFormField(
                      controller: controller.jumlahC,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Jumlah",
                        hintText: "Mis. 50000",
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

                    // Keterangan
                    TextFormField(
                      controller: controller.keteranganC,
                      decoration: InputDecoration(
                        labelText: "Keterangan",
                        hintText: "Keterangan (opsional)",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Tombol Simpan
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.simpanPengeluaran();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: const Color(0xFFAEC6CF), // pastel pink
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
