import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ScreenTimeChart extends StatelessWidget {
  const ScreenTimeChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330,
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
            "Today's Screen Time",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            "Entertainment vs Productive Apps",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 25),

          Expanded(
            child: BarChart(
              BarChartData(
                maxY: 240,

                alignment: BarChartAlignment.spaceAround,

                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 60,
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
                      interval: 60,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          "${value.toInt()}m",
                          style: const TextStyle(fontSize: 11),
                        );
                      },
                    ),
                  ),

                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {

                        const labels = [
                          "IG",
                          "YT",
                          "WA",
                          "Chrome",
                          "VS",
                          "LC"
                        ];

                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            labels[value.toInt()],
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                barGroups: [

                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                        toY: 140,
                        width: 20,
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ],
                  ),

                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(
                        toY: 180,
                        width: 20,
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ],
                  ),

                  BarChartGroupData(
                    x: 2,
                    barRods: [
                      BarChartRodData(
                        toY: 90,
                        width: 20,
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ],
                  ),

                  BarChartGroupData(
                    x: 3,
                    barRods: [
                      BarChartRodData(
                        toY: 70,
                        width: 20,
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ],
                  ),

                  BarChartGroupData(
                    x: 4,
                    barRods: [
                      BarChartRodData(
                        toY: 110,
                        width: 20,
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ],
                  ),

                  BarChartGroupData(
                    x: 5,
                    barRods: [
                      BarChartRodData(
                        toY: 65,
                        width: 20,
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Wrap(
            spacing: 18,
            runSpacing: 10,
            children: const [

              LegendItem(
                color: Colors.pink,
                title: "Instagram",
              ),

              LegendItem(
                color: Colors.red,
                title: "YouTube",
              ),

              LegendItem(
                color: Colors.green,
                title: "WhatsApp",
              ),

              LegendItem(
                color: Colors.orange,
                title: "Chrome",
              ),

              LegendItem(
                color: Colors.blue,
                title: "VS Code",
              ),

              LegendItem(
                color: Colors.deepPurple,
                title: "LeetCode",
              ),

            ],
          )

        ],
      ),
    );
  }
}

class LegendItem extends StatelessWidget {

  final Color color;
  final String title;

  const LegendItem({
    super.key,
    required this.color,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [

        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),

        const SizedBox(width: 6),

        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),

      ],
    );
  }
}