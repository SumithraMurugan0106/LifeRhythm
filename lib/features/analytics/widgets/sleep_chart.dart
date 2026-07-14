import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SleepChart extends StatelessWidget {
  const SleepChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.15),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Sleep Delay Analysis",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            "Intended vs Actual Bedtime",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: 6,

                minY: 21,
                maxY: 25,

                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 1,
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
                      showTitles: true,
                      interval: 1,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        switch (value.toInt()) {
                          case 21:
                            return const Text("9 PM");

                          case 22:
                            return const Text("10 PM");

                          case 23:
                            return const Text("11 PM");

                          case 24:
                            return const Text("12 AM");

                          case 25:
                            return const Text("1 AM");
                        }

                        return const SizedBox();
                      },
                    ),
                  ),

                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        const days = [
                          "Mon",
                          "Tue",
                          "Wed",
                          "Thu",
                          "Fri",
                          "Sat",
                          "Sun"
                        ];

                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(days[value.toInt()]),
                        );
                      },
                    ),
                  ),
                ),

                lineBarsData: [

                  /// Target Sleep

                  LineChartBarData(
                    isCurved: true,
                    color: Colors.green,
                    barWidth: 4,

                    spots: const [

                      FlSpot(0,22),
                      FlSpot(1,22),
                      FlSpot(2,22),
                      FlSpot(3,22),
                      FlSpot(4,22),
                      FlSpot(5,22),
                      FlSpot(6,22),

                    ],

                    dotData: const FlDotData(show: false),

                  ),

                  /// Actual Sleep

                  LineChartBarData(
                    isCurved: true,
                    color: Colors.red,
                    barWidth: 4,

                    spots: const [

                      FlSpot(0,23),

                      FlSpot(1,24),

                      FlSpot(2,22.5),

                      FlSpot(3,24.2),

                      FlSpot(4,23.5),

                      FlSpot(5,22.8),

                      FlSpot(6,23.3),

                    ],

                    belowBarData: BarAreaData(
                      show: true,
                      color: Colors.red.withOpacity(.15),
                    ),

                  ),

                ],
              ),
            ),
          ),

          const SizedBox(height: 15),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Row(
                children: [

                  Container(
                    width: 16,
                    height: 16,
                    color: Colors.green,
                  ),

                  const SizedBox(width: 8),

                  const Text("Target"),

                ],
              ),

              Row(
                children: [

                  Container(
                    width: 16,
                    height: 16,
                    color: Colors.red,
                  ),

                  const SizedBox(width: 8),

                  const Text("Actual"),

                ],
              ),

            ],
          )
        ],
      ),
    );
  }
}