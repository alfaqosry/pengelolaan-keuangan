import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:keuangan/app/modules/home/controllers/home_controller.dart';
import '../controllers/laporan_controller.dart';
import 'package:intl/intl.dart';

class LaporanView extends GetView<LaporanController> {
  const LaporanView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final List<Color> pastelColors = [
      Color(0xFFB5EAD7),
      Color(0xFFFFDAC1),
      Color(0xFFFFC3A0),
      Color(0xFFBFD3C1),
      Color(0xFFF8B195),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan Keuangan'),
        centerTitle: true,
        backgroundColor: const Color(0xFF8FAEBB),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Obx(() {
            final pemasukan = homeController.totalPemasukan.value;
            final pengeluaran = homeController.totalPengeluaran.value;
            final saldo = pemasukan - pengeluaran;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ringkasan",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _ringkasanBox("Pemasukan", pemasukan, Colors.green),
                    _ringkasanBox("Pengeluaran", pengeluaran, Colors.red),
                    _ringkasanBox(
                      "Saldo",
                      saldo,
                      saldo >= 0 ? Colors.blue : Colors.red[700]!,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: PieChart(
                      dataMap: {
                        "Pemasukan": pemasukan.toDouble(),
                        "Pengeluaran": pengeluaran.toDouble(),
                      },
                      chartType: ChartType.ring,
                      chartRadius: MediaQuery.of(context).size.width / 2.2,
                      animationDuration: const Duration(milliseconds: 1000),
                      colorList: pastelColors,
                      chartValuesOptions: const ChartValuesOptions(
                        showChartValuesInPercentage: true,
                        showChartValues: true,
                        showChartValueBackground: false,
                      ),
                      legendOptions: const LegendOptions(
                        showLegends: true,
                        legendPosition: LegendPosition.bottom,
                        legendTextStyle: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _ringkasanBox(String label, int value, Color color) {
    return Expanded(
      child: Container(
        height: 80,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color, width: 1.2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                _formatUang(value),
                style: TextStyle(
                  color: color,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatUang(int angka) {
    if (angka >= 1000000000) {
      return '${(angka / 1000000000).toStringAsFixed(1)} M';
    } else if (angka >= 1000000) {
      return '${(angka / 1000000).toStringAsFixed(1)} JT';
    } else {
      return NumberFormat.currency(
        locale: 'id_ID',
        symbol: 'Rp ',
      ).format(angka);
    }
  }
}
