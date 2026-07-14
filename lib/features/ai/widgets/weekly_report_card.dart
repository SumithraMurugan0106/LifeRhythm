import 'package:flutter/material.dart';

class WeeklyReportCard extends StatelessWidget {
  final int productiveHours;
  final int entertainmentHours;
  final int focusScore;
  final String aiSummary;

  const WeeklyReportCard({
    super.key,
    required this.productiveHours,
    required this.entertainmentHours,
    required this.focusScore,
    required this.aiSummary,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Row(
              children: const [

                CircleAvatar(
                  radius: 22,
                  backgroundColor: Color(0xffEEF4FF),
                  child: Icon(
                    Icons.analytics,
                    color: Colors.blue,
                  ),
                ),

                SizedBox(width: 12),

                Text(
                  "Weekly Reality Check",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 25),

            Row(
              children: [

                Expanded(
                  child: _statCard(
                    Icons.work,
                    "Productive",
                    "$productiveHours hrs",
                    Colors.green,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _statCard(
                    Icons.phone_android,
                    "Entertainment",
                    "$entertainmentHours hrs",
                    Colors.red,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 20),

            Text(
              "Focus Score",
              style: TextStyle(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: focusScore / 100,
                minHeight: 12,
                color: _getColor(focusScore),
                backgroundColor: Colors.grey.shade300,
              ),
            ),

            const SizedBox(height: 10),

            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "$focusScore / 100",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(18),
              ),

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  const Icon(
                    Icons.psychology,
                    color: Colors.blue,
                    size: 30,
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: Text(
                      aiSummary,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.6,
                      ),
                    ),
                  )

                ],
              ),
            ),

            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(18),
              ),

              child: Row(
                children: const [

                  Icon(
                    Icons.emoji_events,
                    color: Colors.orange,
                  ),

                  SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      "Keep reducing screen time by 30 minutes every day to improve your Life Drift Score.",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _statCard(
      IconData icon,
      String title,
      String value,
      Color color,
      ) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: color.withOpacity(.08),
        borderRadius: BorderRadius.circular(18),
      ),

      child: Column(
        children: [

          Icon(
            icon,
            color: color,
            size: 34,
          ),

          const SizedBox(height: 10),

          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
            ),
          )

        ],
      ),
    );
  }

  Color _getColor(int score) {
    if (score >= 80) return Colors.green;
    if (score >= 60) return Colors.orange;
    return Colors.red;
  }
}