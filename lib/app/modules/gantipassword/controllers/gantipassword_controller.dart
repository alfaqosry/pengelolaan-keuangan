import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class GantipasswordController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Controller input
  final TextEditingController oldPassC = TextEditingController();
  final TextEditingController newPassC = TextEditingController();
  final TextEditingController confirmPassC = TextEditingController();

  // Loading observable
  var isLoading = false.obs;

  // Fungsi ubah password
  Future<void> changePassword() async {
    if (newPassC.text != confirmPassC.text) {
      Get.snackbar("Error", "Password baru dan konfirmasi tidak sama");
      return;
    }

    isLoading.value = true;
    try {
      final user = _auth.currentUser;
      if (user != null && user.email != null) {
        // Re-authenticate dengan password lama
        final cred = EmailAuthProvider.credential(
          email: user.email!,
          password: oldPassC.text,
        );
        await user.reauthenticateWithCredential(cred);

        // Update password
        await user.updatePassword(newPassC.text);

        Get.snackbar("Success", "Password berhasil diubah");

        // Bersihkan field
        oldPassC.clear();
        newPassC.clear();
        confirmPassC.clear();
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message ?? "Terjadi kesalahan");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    oldPassC.dispose();
    newPassC.dispose();
    confirmPassC.dispose();
    super.onClose();
  }
}
