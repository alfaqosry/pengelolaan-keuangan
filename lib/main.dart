import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'app/controllers/auth_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/loading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Inject AuthController secara global
  Get.put(AuthController(), permanent: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authC.streameAuthStatus,
      builder: (context, snapshot) {
        // Saat koneksi stream aktif (dapat data dari Firebase)
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;

          // Jika sudah login dan email sudah diverifikasi
          if (user != null && user.emailVerified) {
            return FutureBuilder<String>(
              future: authC.determineStartRoute(user),
              builder: (context, routeSnapshot) {
                if (routeSnapshot.connectionState == ConnectionState.done) {
                  return GetMaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: "Aplikasi Keuangan Mahasiswa",
                    initialRoute: routeSnapshot.data!,
                    getPages: AppPages.routes,
                  );
                }

                // Masih loading Firestore data
                return LoadingView();
              },
            );
          }

          // User belum login atau belum verifikasi email
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Aplikasi Keuangan Mahasiswa",
            initialRoute: Routes.LOGIN,
            getPages: AppPages.routes,
          );
        }

        // Masih loading dari stream Firebase
        return LoadingView();
      },
    );
  }
}
