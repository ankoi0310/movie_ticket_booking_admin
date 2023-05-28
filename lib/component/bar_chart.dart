import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';

class BarChartCopmponent extends StatelessWidget {
  const BarChartCopmponent({
    Key? key,
    required this.data,
    required this.timeline,
  }) : super(key: key);

  final Map<String, int> data;
  final StatisticTimeline timeline;

  @override
  Widget build(BuildContext context) {
    int length = 0;

    switch (timeline) {
      case StatisticTimeline.week:
        length = 7;
        break;
      case StatisticTimeline.month:
        length = 30;
        break;
      case StatisticTimeline.year:
        length = 12;
        break;
      case StatisticTimeline.day:
        length = 1;
        break;
    }

    return BarChart(
      BarChartData(
        borderData: FlBorderData(show: false),
        alignment: BarChartAlignment.spaceBetween,
        // gridData: FlGridData(drawHorizontalLine: true, horizontalInterval: 30),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value == 0) {
                  return const Text(
                    '0',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  );
                } else if (value == 500000) {
                  return const Text(
                    '500k',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  );
                } else if (value == 1000000) {
                  return const Text(
                    '1000k',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  );
                } else if (value == 1500000) {
                  return const Text(
                    '1500k',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  );
                } else {
                  return const Text(
                    '',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  );
                }
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(
                  '$value',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                );
              },
            ),
          ),
        ),
        barGroups: List.generate(
          data.keys.length,
          (index) => BarChartGroupData(
            x: index + 1,
            barRods: [
              BarChartRodData(
                toY: data.values.elementAt(index).toDouble(),
                color: Colors.black,
                borderRadius: BorderRadius.circular(0),
                width: Responsive.isDesktop(context) ? 40 : 10,
                backDrawRodData: BackgroundBarChartRodData(
                  toY: data.values.elementAt(index).toDouble(),
                  show: true,
                  color: AppColors.barBg,
                ),
              ),
            ],
          ),
        ),
      ),
      // swapAnimationDuration: const Duration(milliseconds: 150), // Optional
      // swapAnimationCurve: Curves.linear, // Optional
    );
  }
}
