import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  TextEditingController resetEmailC = TextEditingController();

  var obscurePassword = true.obs;
  var isLoading = false.obs;
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void setLoading(bool value) {
    isLoading.value = value;
  }

  @override
  void onClose() {
    emailC.dispose();
    passC.dispose();
    resetEmailC.dispose();
    super.onClose();
  }
}
