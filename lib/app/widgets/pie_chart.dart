import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import '../modules/home/controllers/home_controller.dart';

class PieChartScreen extends StatelessWidget {
  PieChartScreen({super.key});

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diagram Pie Keuangan"),
        backgroundColor: Color(0xFFAEC6CF),
        foregroundColor: Colors.black87,
        centerTitle: true,
      ),
      body: Center(
        child: Obx(
          () => PieChart(
            dataMap: {
              "Pemasukan": controller.totalPemasukan.value.toDouble(),
              "Pengeluaran": controller.totalPengeluaran.value.toDouble(),
            },
            chartType: ChartType.disc,
            animationDuration: Duration(milliseconds: 800),
            chartRadius: MediaQuery.of(context).size.width / 2,
            colorList: [Colors.green, Colors.red],
            chartValuesOptions: ChartValuesOptions(
              showChartValuesInPercentage: true,
              showChartValues: true,
              showChartValueBackground: false,
            ),
            legendOptions: LegendOptions(
              showLegends: true,
              legendPosition: LegendPosition.bottom,
            ),
          ),
        ),
      ),
    );
  }
}
