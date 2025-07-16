import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:keuangan/app/routes/app_pages.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Stream<User?> get streameAuthStatus => auth.authStateChanges();

  /// GOOGLE SIGN-IN
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        Get.snackbar("Gagal", "Login dibatalkan oleh pengguna");
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user == null) {
        Get.snackbar("Gagal", "User tidak ditemukan setelah login.");
        return;
      }

      final isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;

      if (isNewUser) {
        await fireStore.collection("users").doc(user.uid).set({
          "uid": user.uid,
          "email": user.email,
          "displayName": user.displayName,
          "photoUrl": user.photoURL,
          "createdAt": DateTime.now(),
        });
      }

      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.snackbar("Error", "Gagal login dengan Google: $e");
    }
  }

  /// EMAIL LOGIN
  Future<void> login(String email, String password) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      await user?.reload();

      if (user != null && user.emailVerified) {
        final userRef = fireStore.collection('users').doc(user.uid);
        final userDoc = await userRef.get();

        if (!userDoc.exists) {
          await userRef.set({
            'email': user.email,
            'tinggal': null,
            'created_at': DateTime.now().toIso8601String(),
          });
        }

        Get.offAllNamed(Routes.HOME);
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
  Future<void> logout() async {
    await auth.signOut();
    await GoogleSignIn().signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  /// EMAIL SIGN-UP
  Future<void> signup(String name, String email, String password) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      await user?.updateDisplayName(name);
      await user?.reload();

      if (user != null) {
        await fireStore.collection('users').doc(user.uid).set({
          'email': email,
          'displayName': name,
          'tinggal': null,
          'created_at': DateTime.now().toIso8601String(),
        });

        await user.sendEmailVerification();

        Get.defaultDialog(
          title: "Verifikasi Email",
          middleText: "Kami telah mengirimkan email verifikasi ke $email",
          onConfirm: () {
            Get.back(); // tutup dialog
            Get.back(); // kembali ke halaman sebelumnya
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      Get.defaultDialog(
        title: "Registrasi Gagal",
        middleText: e.message ?? "Terjadi kesalahan saat mendaftar",
      );
    }
  }
}
