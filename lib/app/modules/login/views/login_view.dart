import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keuangan/app/controllers/auth_controller.dart';
import 'package:keuangan/app/routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'LOGIN',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextField(
                controller: controller.emailC,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => TextField(
                  controller: controller.passC,
                  obscureText: controller.obscurePassword.value,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.obscurePassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () async {
                            if (controller.emailC.text.isEmpty ||
                                controller.passC.text.isEmpty) {
                              Get.snackbar(
                                "Peringatan",
                                "Email dan Password tidak boleh kosong",
                              );
                              return;
                            }
                            controller.setLoading(true);
                            await authC.login(
                              controller.emailC.text,
                              controller.passC.text,
                            );
                            controller.setLoading(false);
                          },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 14,
                      ),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Belum memiliki akun?'),
                  TextButton(
                    onPressed: () => Get.toNamed(Routes.SIGNUP),
                    child: Text("Daftar"),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => authC.signInWithGoogle(),

                  label: Text("Masuk dengan Google"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
