import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/create_alokasi_controller.dart';

class CreateAlokasiView extends GetView<CreateAlokasiController> {
  const CreateAlokasiView({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Alokasi Dana"),
        backgroundColor: const Color(0xFFAEC6CF),
        foregroundColor: Colors.black87,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Nama Alokasi
              TextFormField(
                controller: controller.namaC,
                decoration: const InputDecoration(
                  labelText: 'Nama Alokasi',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Nama tidak boleh kosong'
                    : null,
              ),
              const SizedBox(height: 12),

              // Jumlah
              TextFormField(
                controller: controller.jumlahC,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Jumlah Alokasi',
                  hintText: 'Mis. 500000',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  final val = int.tryParse(value ?? '');
                  if (val == null || val <= 0)
                    return 'Masukkan jumlah yang valid';
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Prioritas Switch
              Obx(
                () => SwitchListTile(
                  title: const Text("Prioritas"),
                  value: controller.isPrioritas.value,
                  onChanged: (val) => controller.isPrioritas.value = val,
                ),
              ),
              const SizedBox(height: 20),

              // Tombol Simpan
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text("Simpan"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFAEC6CF),
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.simpanAlokasi();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
