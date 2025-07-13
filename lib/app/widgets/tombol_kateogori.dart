import 'package:flutter/material.dart';

class TombolKategori extends StatelessWidget {
  final String kategoriTombol;
  final VoidCallback? onTap;
  TombolKategori({super.key, required this.kategoriTombol, this.onTap});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        backgroundColor: const Color(0xFFAEC6CF),
        foregroundColor: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // bentuk badge bulat
        ),
        elevation: 0,
        minimumSize: Size(0, 30), // tinggi kecil
        tapTargetSize: MaterialTapTargetSize.shrinkWrap, // supaya rapat
      ),
      child: Text(
        kategoriTombol,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }
}
