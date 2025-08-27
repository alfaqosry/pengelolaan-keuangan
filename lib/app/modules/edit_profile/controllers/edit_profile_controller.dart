import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Controller input
  final TextEditingController nameC = TextEditingController();
  final TextEditingController oldPassC = TextEditingController();
  final TextEditingController newPassC = TextEditingController();

  // Data observable
  var name = "".obs;
  var email = "".obs;
  var isLoading = false.obs;

  // Load data profile dari Firestore
  void loadUserProfile() async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid != null) {
        final doc = await _firestore.collection("users").doc(uid).get();
        name.value = doc["displayName"] ?? "";
        email.value = _auth.currentUser?.email ?? "";
        nameC.text = name.value;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> updateProfile() async {
    isLoading.value = true;
    try {
      final uid = _auth.currentUser?.uid;
      if (uid != null) {
        await _firestore.collection("users").doc(uid).update({
          "displayName": nameC.text,
        });

        await _auth.currentUser!.updateDisplayName(nameC.text);
        await _auth.currentUser!.reload();

        name.value = nameC.text;

        Get.snackbar("Success", "Profil berhasil diperbarui");
        Get.offAllNamed('/profile');
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Ubah password
  Future<void> changePassword() async {
    isLoading.value = true;
    try {
      final user = _auth.currentUser;
      if (user != null) {
        // re-authenticate dulu
        final cred = EmailAuthProvider.credential(
          email: user.email!,
          password: oldPassC.text,
        );
        await user.reauthenticateWithCredential(cred);

        // ganti password
        await user.updatePassword(newPassC.text);

        Get.snackbar("Success", "Password berhasil diubah");
        oldPassC.clear();
        newPassC.clear();
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message ?? "Terjadi kesalahan");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  @override
  void onClose() {
    nameC.dispose();
    oldPassC.dispose();
    newPassC.dispose();
    super.onClose();
  }
}
