import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_app/common/sizes.dart';
import 'package:get/get.dart';
import '../controllers/employee_controller.dart';
import '../widgets/my_app_bar.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key});

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
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: sizes.height220),
        child: Obx(() {
          if (employeeController.projectProgress.isEmpty) {
            return const Center(
              child: Text('No data available'),
            );
          }
          print('Project Progress Data: ${employeeController.projectProgress}');

          List<FlSpot> spots = employeeController.projectProgress.map((data) {
            DateTime date = data['ComPro Date'];
            double x = date.difference(DateTime(2024)).inDays.toDouble(); // Use days since a reference date
            double y = data['Completed Projects'].toDouble();
            return FlSpot(x, y);
          }).toList();

          return LineChart(
            LineChartData(
              gridData: const FlGridData(show: true),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta) {
                    return Text(value.toInt().toString());
                  }),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      DateTime date = DateTime(2024).add(Duration(days: value.toInt())); // Convert days back to date
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
      ),
    );
  }
}
