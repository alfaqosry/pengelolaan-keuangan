import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  var obscurePassword = true.obs;
  var isLoading = false.obs;
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }
}
