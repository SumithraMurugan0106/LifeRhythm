import 'package:flutter/material.dart';

class AppUsageList extends StatelessWidget {
  const AppUsageList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<AppUsage> apps = [
      AppUsage(
        name: "Instagram",
        icon: Icons.camera_alt,
        minutes: 142,
        progress: 0.92,
        color: Colors.pink,
      ),
      AppUsage(
        name: "YouTube",
        icon: Icons.play_circle_fill,
        minutes: 118,
        progress: 0.78,
        color: Colors.red,
      ),
      AppUsage(
        name: "WhatsApp",
        icon: Icons.chat,
        minutes: 84,
        progress: 0.55,
        color: Colors.green,
      ),
      AppUsage(
        name: "Chrome",
        icon: Icons.language,
        minutes: 62,
        progress: 0.40,
        color: Colors.orange,
      ),
      AppUsage(
        name: "VS Code",
        icon: Icons.code,
        minutes: 105,
        progress: 0.70,
        color: Colors.blue,
      ),
      AppUsage(
        name: "LeetCode",
        icon: Icons.emoji_events,
        minutes: 48,
        progress: 0.32,
        color: Colors.deepPurple,
      ),
    ];

    return Column(
      children: apps
          .map(
            (app) => Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: _AppUsageTile(app: app),
        ),
      )
          .toList(),
    );
  }
}

class _AppUsageTile extends StatelessWidget {
  final AppUsage app;

  const _AppUsageTile({
    required this.app,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.12),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: app.color.withOpacity(.15),
            child: Icon(
              app.icon,
              color: app.color,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  app.name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: app.progress,
                    minHeight: 8,
                    backgroundColor: Colors.grey.shade300,
                    color: app.color,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 18),

          Column(
            children: [
              Text(
                "${app.minutes}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "mins",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AppUsage {
  final String name;
  final IconData icon;
  final int minutes;
  final double progress;
  final Color color;

  AppUsage({
    required this.name,
    required this.icon,
    required this.minutes,
    required this.progress,
    required this.color,
  });
}