// lib/app/widgets/main_navigation.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keuangan/app/modules/alokasi/controllers/alokasi_controller.dart';
import 'package:keuangan/app/modules/alokasi/views/alokasi_view.dart';
import 'package:keuangan/app/modules/home/controllers/home_controller.dart';
import 'package:keuangan/app/modules/laporan/controllers/laporan_controller.dart';
import 'package:keuangan/app/modules/laporan/views/laporan_view.dart';
import '../controllers/navigation_controller.dart';
import '../modules/home/views/home_view.dart';
import '../modules/profile/views/profile_view.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  final navC = Get.put(NavigationController(), permanent: true);
  final alokasiC = Get.put(AlokasiController(), permanent: true);
  final laporanC = Get.put(LaporanController(), permanent: true);
  final homeC = Get.put(HomeController(), permanent: true);

  final List<Widget> pages = [
    HomeView(),
    AlokasiView(),
    LaporanView(),
    ProfileView(),
  ];

  @override
  void initState() {
    super.initState();
    // 🟢 Panggil ulang agar ambil data sesuai user login sekarang
    Future.delayed(Duration.zero, () {
      alokasiC.listenToAlokasiRealtime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: pages[navC.selectedIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          currentIndex: navC.selectedIndex.value,
          onTap: navC.changeTabIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              label: 'Alokasi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.insert_chart),
              label: 'Laporan',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          ],
        ),
      ),
    );
  }
}
