import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../models/usage_app_model.dart';

class UsageChart extends StatelessWidget {
  final List<UsageAppModel> apps;

  const UsageChart({
    super.key,
    required this.apps,
  });

  @override
  Widget build(BuildContext context) {
    if (apps.isEmpty) {
      return const SizedBox(
        height: 250,
        child: Center(
          child: Text("No usage data available"),
        ),
      );
    }

    final topApps = List<UsageAppModel>.from(apps)
      ..sort((a, b) => b.usageTimeMillis.compareTo(a.usageTimeMillis));

    final chartApps =
    topApps.length > 5 ? topApps.sublist(0, 5) : topApps;

    final maxUsage = chartApps.first.usageTimeMillis.toDouble();

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "Today's Screen Time",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 25),

          SizedBox(
            height: 250,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: maxUsage,
                gridData: FlGridData(
                  show: true,
                  horizontalInterval: maxUsage / 5,
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(

                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),

                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),

                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      reservedSize: 45,
                      showTitles: true,
                      interval: maxUsage / 5,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          "${(value / 60000).round()}m",
                          style: const TextStyle(fontSize: 11),
                        );
                      },
                    ),
                  ),

                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {

                        final index = value.toInt();

                        if (index >= chartApps.length) {
                          return const SizedBox();
                        }

                        final app = chartApps[index];

                        String label = app.appName;

                        if (label.length > 8) {
                          label = label.substring(0, 8);
                        }

                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            label,
                            style: const TextStyle(fontSize: 11),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                barGroups: List.generate(
                  chartApps.length,
                      (index) {

                    final app = chartApps[index];

                    return BarChartGroupData(
                      x: index,
                      barRods: [

                        BarChartRodData(
                          toY: app.usageTimeMillis.toDouble(),
                          width: 22,
                          borderRadius:
                          BorderRadius.circular(8),
                          color: _getColor(index),
                        ),

                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getColor(int index) {

    const colors = [

      Colors.red,

      Colors.blue,

      Colors.orange,

      Colors.green,

      Colors.purple,

    ];

    return colors[index % colors.length];
  }
}