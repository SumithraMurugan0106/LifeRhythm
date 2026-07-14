import 'package:flutter/material.dart';

class AIInsightCard extends StatelessWidget {
  final String insight;
  final String title;

  const AIInsightCard({
    super.key,
    required this.insight,
    this.title = "Today's AI Insight",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Color(0xff4F8EF7),
            Color(0xff7B61FF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(.25),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.auto_awesome,
                  color: Color(0xff4F8EF7),
                ),
              ),
              SizedBox(width: 12),
              Text(
                "LifeRhythm AI",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            insight,
            style: const TextStyle(
              color: Colors.white,
              height: 1.6,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: const [
              Icon(
                Icons.lightbulb,
                color: Colors.amber,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Small improvements every day create remarkable long-term results.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.18),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: const [
                Icon(
                  Icons.bolt,
                  color: Colors.yellow,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Today's Goal: Reduce social media usage by 30 minutes.",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}