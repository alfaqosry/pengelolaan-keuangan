import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController passC = TextEditingController();

  var obscurePassword = true.obs;
  var isLoading = false.obs;
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  @override
  void onClose() {
    emailC.dispose();
    passC.dispose();
    nameC.dispose();
    super.onClose();
  }
}
