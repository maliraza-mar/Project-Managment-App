import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_app/common/sizes.dart';
import 'package:get/get.dart';
import '../controllers/employee_controller.dart';
import '../widgets/my_app_bar.dart';


class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EmployeeController employeeController = Get.put(EmployeeController());
    final sizes = Sizes(context);

    return Scaffold(
      appBar: MyAppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
          ),
          iconSize: sizes.responsiveIconSize18,
        ),
        title: 'Progress',
      ),
      body: Obx(() {
        if (employeeController.projectProgress.isEmpty) {
          return const Center(
            child: Text('No data available'),
          );
        }

        List<FlSpot> spots = employeeController.projectProgress.map((data) {
          DateTime date = data['date'];
          double x = date.day.toDouble() + (date.month - 1) * 30; // Simplified conversion
          double y = data['Completed Projects'].toDouble();
          return FlSpot(x, y);
        }).toList();

        return LineChart(
          LineChartData(
            gridData: FlGridData(show: true),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    DateTime date = DateTime(2023, 1, 2); // Simplified conversion
                    //DateTime date = DateTime(2023, (value ~/ 30) + 1, (value % 30) as int); // Simplified conversion
                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      space: 4,
                      child: Text(DateFormat('d MMM').format(date)),
                    );
                  },
                ),
              ),
            ),
            borderData: FlBorderData(show: true),
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                color: Colors.blue,
                barWidth: 4,
                belowBarData: BarAreaData(show: true, color: Colors.blue.withOpacity(0.3)),
              ),
            ],
          ),
        );
      }),
    );
  }
}
