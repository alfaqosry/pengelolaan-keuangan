import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:keuangan/app/routes/app_pages.dart';

class AuthController extends GetxController {
  // FirebaseAuth auth = FirebaseAuth.instance.authStateChanges();
  // Stream<User?> streameAuthStatus() {
  //   return auth.authStateChanges();
  // }

  FirebaseAuth auth = FirebaseAuth.instance;
  Stream<User?> get streameAuthStatus => auth.authStateChanges();

  void login(String email, String password) async {
    print(email);
    try {
      UserCredential myUser = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (myUser.user!.emailVerified) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.defaultDialog(
          title: "Verifikasi Email",
          middleText: "Kamu perlu verifikasi email dulu",
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void logout() async {
    await auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  void signup(String email, String password) async {
    try {
      UserCredential myUser = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (myUser.user!.emailVerified) {
        Get.offAllNamed(Routes.HOME);
      } else {
        await myUser.user?.sendEmailVerification();
        Get.defaultDialog(
          title: "Verifikasi Email",
          middleText: "Kami telah mengirimkan email verifikasi",
          onConfirm: () {
            Get.back();
            Get.back();
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
