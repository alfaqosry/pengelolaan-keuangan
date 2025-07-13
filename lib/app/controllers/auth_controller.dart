import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:keuangan/app/routes/app_pages.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Stream<User?> get streameAuthStatus => auth.authStateChanges();

  /// LOGIN
  Future<void> login(String email, String password) async {
    try {
      UserCredential myUser = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = myUser.user;
      await user?.reload();

      if (user != null && user.emailVerified) {
        final userRef = fireStore.collection('users').doc(user.uid);
        final userDoc = await userRef.get();

        // Jika belum ada dokumen user, buat
        if (!userDoc.exists) {
          await userRef.set({
            'email': user.email,
            'tinggal': null,
            'created_at': DateTime.now().toIso8601String(),
          });
        }

        final route = Routes.HOME;
        Get.offAllNamed(route);
      } else {
        Get.defaultDialog(
          title: "Verifikasi Email",
          middleText: "Silakan verifikasi email terlebih dahulu.",
        );
      }
    } on FirebaseAuthException catch (e) {
      Get.defaultDialog(
        title: "Login Gagal",
        middleText: e.message ?? "Terjadi kesalahan saat login.",
      );
    } catch (e) {
      Get.defaultDialog(
        title: "Kesalahan",
        middleText: "Terjadi kesalahan tidak terduga: $e",
      );
    }
  }

  /// LOGOUT
  void logout() async {
    await auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  /// SIGNUP
  void signup(String name, String email, String password) async {
    try {
      UserCredential myUser = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await myUser.user?.updateDisplayName(name);
      await myUser.user?.reload();

      await fireStore.collection('users').doc(myUser.user!.uid).set({
        'email': email,
        'displayName': name,
        'tinggal': null,
        'created_at': DateTime.now().toIso8601String(),
      });

      await myUser.user?.sendEmailVerification();

      Get.defaultDialog(
        title: "Verifikasi Email",
        middleText: "Kami telah mengirimkan email verifikasi ke $email",
        onConfirm: () {
          Get.back(); // tutup dialog
          Get.back(); // kembali ke halaman sebelumnya
        },
      );
    } on FirebaseAuthException catch (e) {
      Get.defaultDialog(
        title: "Registrasi Gagal",
        middleText: e.message ?? "Terjadi kesalahan saat mendaftar",
      );
    }
  }
}
