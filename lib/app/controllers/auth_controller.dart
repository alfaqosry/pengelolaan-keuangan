import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:keuangan/app/routes/app_pages.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Stream<User?> get streameAuthStatus => auth.authStateChanges();

  void login(String email, String password) async {
    print(email);
    try {
      UserCredential myUser = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? datauser = myUser.user;
      await datauser?.reload();

      if (datauser != null && datauser.emailVerified) {
        try {
          DocumentSnapshot userDoc = await fireStore
              .collection('users')
              .doc(datauser.uid)
              .get();

          // Buat dokumen jika belum ada
          if (!userDoc.exists) {
            await fireStore.collection('users').doc(datauser.uid).set({
              'email': datauser.email,
              'tinggal': null,
              'created_at': DateTime.now().toIso8601String(),
            });
          }

          // Ambil data user dan cek field "tinggal"
          final data = userDoc.data() as Map<String, dynamic>?;
          final bool belumIsiProfil = data == null || data['tinggal'] == null;

          print("cek boy: $belumIsiProfil");

          if (belumIsiProfil) {
            Get.offAllNamed(Routes.ISI_PROFILE);
          } else {
            Get.offAllNamed(Routes.HOME);
          }
        } catch (e) {
          print("Firestore error: $e");
        }
      } else {
        Get.defaultDialog(
          title: "Verifikasi Email",
          middleText: "Kamu perlu verifikasi email dulu",
        );
      }
    } on FirebaseAuthException catch (e) {
      Get.defaultDialog(
        title: "Login Gagal",
        middleText: e.message ?? "Terjadi kesalahan",
      );
    }
  }

  void logout() async {
    await auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

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
          Get.back();
          Get.back();
        },
      );
    } on FirebaseAuthException catch (e) {
      Get.defaultDialog(
        title: "Registrasi Gagal",
        middleText: e.message ?? "Terjadi kesalahan saat mendaftar",
      );
    }
  }

  Future<String> determineStartRoute(User user) async {
    try {
      final doc = await fireStore.collection('users').doc(user.uid).get();

      // Cek apakah user doc ada
      if (!doc.exists) {
        return Routes.ISI_PROFILE;
      }

      // Cek apakah user sudah punya isian di subcollection 'jawaban_user'
      final jawabanSnapshot = await fireStore
          .collection('users')
          .doc(user.uid)
          .collection('jawaban_user')
          .get();

      final sudahIsiProfil = jawabanSnapshot.docs.isNotEmpty;

      if (sudahIsiProfil) {
        return Routes.HOME; // Dashboard
      } else {
        return Routes.ISI_PROFILE;
      }
    } catch (e) {
      print("Error cek Firestore: $e");
      return Routes.LOGIN; // fallback kalau error
    }
  }
}
