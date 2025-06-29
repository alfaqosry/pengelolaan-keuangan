// lib/app/widgets/main_navigation.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keuangan/app/modules/laporan/views/laporan_view.dart';
import '../controllers/navigation_controller.dart';
import '../modules/home/views/home_view.dart';
import '../modules/profile/views/profile_view.dart';

class MainNavigation extends StatelessWidget {
  final navC = Get.put(
    NavigationController(),
    permanent: true,
  ); // inject controller

  final List<Widget> pages = [HomeView(), LaporanView(), ProfileView()];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: pages[navC.selectedIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: navC.selectedIndex.value,
          onTap: navC.changeTabIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Riwayat',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          ],
        ),
      ),
    );
  }
}
