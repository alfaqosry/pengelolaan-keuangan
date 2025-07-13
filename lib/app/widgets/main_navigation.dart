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

class MainNavigation extends StatelessWidget {
  MainNavigation({super.key}) {
    // Inject controller saat navigasi dibuat
    Get.put(NavigationController(), permanent: true);
    Get.put(AlokasiController(), permanent: true);
    Get.put(LaporanController(), permanent: true);
    Get.put(HomeController(), permanent: true);
  }

  final navC = Get.find<NavigationController>(); // cukup pakai Get.find

  final List<Widget> pages = [
    HomeView(),
    AlokasiView(),
    LaporanView(),
    ProfileView(),
  ];

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
