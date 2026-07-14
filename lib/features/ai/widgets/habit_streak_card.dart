import 'package:flutter/material.dart';

class HabitStreakCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final int streak;
  final IconData icon;
  final Color color;
  final double progress;

  const HabitStreakCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.streak,
    required this.icon,
    required this.color,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.12),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.all(18),

        child: Row(
          children: [

            CircleAvatar(
              radius: 28,
              backgroundColor: color.withOpacity(.15),

              child: Icon(
                icon,
                size: 30,
                color: color,
              ),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 12),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),

                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                      color: color,
                      backgroundColor: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 20),

            Column(
              children: [

                Text(
                  "$streak",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),

                const Text(
                  "Days",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 8),

                Icon(
                  Icons.local_fire_department,
                  color: color,
                  size: 30,
                ),

              ],
            )

          ],
        ),
      ),
    );
  }
}