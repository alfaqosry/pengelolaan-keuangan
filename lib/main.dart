import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';

import 'app/controllers/auth_controller.dart';
import 'app/controllers/navigation_controller.dart';
import 'app/modules/alokasi/controllers/alokasi_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/loading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Inject controller global
  Get.put(AuthController(), permanent: true);
  Get.put(AlokasiController(), permanent: true);
  Get.put(NavigationController(), permanent: true);
  FirebaseAuth.instance.setLanguageCode('id');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authC.streameAuthStatus,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;

          if (user != null) {
            return FutureBuilder(
              future: user.reload(),
              builder: (context, snapshot) {
                final refreshedUser = FirebaseAuth.instance.currentUser;

                if (refreshedUser != null && refreshedUser.emailVerified) {
                  return _buildApp(Routes.HOME);
                } else {
                  return _buildApp(Routes.LOGIN);
                }
              },
            );
          }

          return _buildApp(Routes.LOGIN);
        }

        return const LoadingView();
      },
    );
  }

  GetMaterialApp _buildApp(String initialRoute) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Aplikasi Keuangan Mahasiswa",
      initialRoute: initialRoute,
      getPages: AppPages.routes,
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
        scaffoldBackgroundColor: Colors.grey[100],
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFAEC6CF)),
        useMaterial3: true,
      ),
    );
  }
}
