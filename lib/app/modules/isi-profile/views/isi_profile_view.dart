import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/isi_profile_controller.dart';

class IsiProfileView extends StatelessWidget {
  final controller = Get.put(IsiProfileController());
  final TextEditingController inputTambahanController = TextEditingController();

  bool isJawabYaDanPerluIsiTambahan(int index) {
    var data = controller.pertanyaanList[index];
    return controller.jawabanYaTidak[index] == true &&
        data.containsKey('tambahan');
  }

  bool isNextEnabled(int index) {
    final jawab = controller.jawabanYaTidak[index];
    if (jawab == null) return false;
    if (!isJawabYaDanPerluIsiTambahan(index)) return true;
    return inputTambahanController.text.trim().isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wizard Pertanyaan')),
      body: Obx(() {
        int index = controller.currentIndex.value;
        bool isLast = index == controller.pertanyaanList.length - 1;
        var pertanyaan = controller.pertanyaanList[index];

        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text(
                'Pertanyaan ${index + 1} dari ${controller.pertanyaanList.length}',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 20),
              Text(
                pertanyaan['teks']!,
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  buildOptionButton(index, "Ya", true),
                  SizedBox(width: 10),
                  buildOptionButton(index, "Tidak", false),
                ],
              ),
              if (isJawabYaDanPerluIsiTambahan(index)) ...[
                SizedBox(height: 20),
                TextField(
                  controller: inputTambahanController,
                  keyboardType: TextInputType.number,
                  onChanged: (_) => controller.currentIndex.refresh(),
                  decoration: InputDecoration(
                    labelText: pertanyaan['tambahan'],
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: index > 0
                        ? () {
                            controller.currentIndex.value--;
                            inputTambahanController.text =
                                controller.jawabanTambahan[index - 1] ?? '';
                          }
                        : null,
                    child: Text('Back'),
                  ),
                  ElevatedButton(
                    onPressed: isNextEnabled(index)
                        ? () {
                            if (isJawabYaDanPerluIsiTambahan(index)) {
                              controller.jawabanTambahan[index] =
                                  inputTambahanController.text.trim();
                              inputTambahanController.clear();
                            }
                            if (isLast) {
                              controller.simpanJawabanKeFirestore();
                            } else {
                              controller.currentIndex.value++;
                            }
                          }
                        : null,
                    child: Text(isLast ? 'Selesai' : 'Next'),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget buildOptionButton(int index, String label, bool value) {
    final isSelected = controller.jawabanYaTidak[index] == value;
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          controller.jawabanYaTidak[index] = value;
          if (!value) {
            inputTambahanController.clear();
            controller.jawabanTambahan[index] = null;
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
          foregroundColor: isSelected ? Colors.white : Colors.black,
          padding: EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(label),
      ),
    );
  }
}
