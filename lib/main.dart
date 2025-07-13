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
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Aplikasi Keuangan Mahasiswa",
      initialRoute: Routes.LOGIN, // selalu mulai dari login
      getPages: AppPages.routes,
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
        scaffoldBackgroundColor: Colors.grey[100],
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFAEC6CF)),
        useMaterial3: true,
      ),
    );
  }
}
