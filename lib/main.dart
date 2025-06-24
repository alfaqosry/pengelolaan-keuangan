import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keuangan/app/controllers/auth_controller.dart';
import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'app/utils/loading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authC = Get.put(AuthController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authC.streameAuthStatus,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;

          if (user != null && user.emailVerified) {
            // Cek apakah profil lengkap
            return FutureBuilder<String>(
              future: authC.determineStartRoute(user),
              builder: (context, routeSnapshot) {
                if (routeSnapshot.connectionState == ConnectionState.done) {
                  return GetMaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: "Application",
                    initialRoute: routeSnapshot.data!,
                    getPages: AppPages.routes,
                  );
                }
                return LoadingView();
              },
            );
          }

          // User belum login atau belum verifikasi email
          return GetMaterialApp(
            title: "Application",
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.LOGIN,
            getPages: AppPages.routes,
          );
        }

        // Masih loading
        return LoadingView();
      },
    );
  }
}
