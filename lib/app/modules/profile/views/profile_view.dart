import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileView extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        centerTitle: true,
        backgroundColor: Color(0xFFAEC6CF),
        foregroundColor: Colors.black87,
      ),
      body: Column(
        children: [
          // Bagian Atas: Foto dan info
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFFAEC6CF),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 50, color: Colors.grey),
                ),
                const SizedBox(height: 12),
                Text(
                  user?.displayName ?? 'Nama Pengguna',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user?.email ?? 'email@example.com',
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Menu Berjajar
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildMenuItem(
                  icon: Icons.edit,
                  title: 'Edit Profil',
                  onTap: () {
                    // TODO: Arahkan ke halaman edit profil
                  },
                ),
                _buildMenuItem(
                  icon: Icons.lock,
                  title: 'Ganti Password',
                  onTap: () {
                    // TODO: Arahkan ke halaman ganti password
                  },
                ),
                _buildMenuItem(
                  icon: Icons.info,
                  title: 'Tentang Aplikasi',
                  onTap: () {
                    Get.dialog(AlertDialog(
                      title: Text("Tentang Aplikasi"),
                      content: Text("Aplikasi Keuangan Mahasiswa v1.0.0"),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(),
                          child: Text("Tutup"),
                        ),
                      ],
                    ));
                  },
                ),
                const Divider(),
                _buildMenuItem(
                  icon: Icons.logout,
                  title: 'Keluar',
                  color: Colors.red,
                  onTap: () {
                    Get.defaultDialog(
                      title: "Konfirmasi",
                      middleText: "Yakin ingin keluar?",
                      textConfirm: "Ya",
                      textCancel: "Batal",
                      confirmTextColor: Colors.white,
                      onConfirm: () async {
                        await FirebaseAuth.instance.signOut();
                        Get.offAllNamed('/login');
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = Colors.black87,
  }) {
   return Container(
  margin: const EdgeInsets.only(bottom: 12),
  decoration: BoxDecoration(
    color: Colors.white, // atau samakan dengan background utama
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: Colors.transparent), // tanpa border
  ),
  child: ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    leading: Icon(icon, color: color),
    title: Text(title, style: TextStyle(color: color)),
    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    onTap: onTap,
  ),
);
  }
}
