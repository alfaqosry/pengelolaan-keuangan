import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/gantipassword_controller.dart';

class GantipasswordView extends GetView<GantipasswordController> {
  const GantipasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text("Ganti Password"),
        centerTitle: true,
        backgroundColor: const Color(0xFFAEC6CF),
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Password Lama",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: controller.oldPassC,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Masukkan password lama",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(Icons.lock_outline),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Password Baru",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: controller.newPassC,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Masukkan password baru",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Konfirmasi Password Baru",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: controller.confirmPassC,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Ulangi password baru",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(Icons.lock_reset),
              ),
            ),
            const SizedBox(height: 24),
            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFAEC6CF),
                    foregroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: controller.isLoading.value
                      ? null
                      : () => controller.changePassword(),
                  child: controller.isLoading.value
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          "Ubah Password",
                          style: TextStyle(fontSize: 16),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
