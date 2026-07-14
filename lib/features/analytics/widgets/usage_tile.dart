import 'package:flutter/material.dart';

import '../../../models/usage_app_model.dart';

class UsageTile extends StatelessWidget {
  final UsageAppModel app;
  final int maxUsage;

  const UsageTile({
    super.key,
    required this.app,
    required this.maxUsage,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = maxUsage == 0
        ? 0
        : app.usageTimeMillis / maxUsage;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [

          /// App Icon
          CircleAvatar(
            radius: 26,
            backgroundColor: Colors.blue.shade50,
            child: Icon(
              _getIcon(app.packageName),
              color: Colors.blue,
            ),
          ),

          const SizedBox(width: 16),

          /// App Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  app.appName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  app.formattedTime,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 12),

                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation(
                      _getColor(progress),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          Text(
            "${(progress * 100).toInt()}%",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _getColor(progress),
            ),
          ),
        ],
      ),
    );
  }

  Color _getColor(double value) {
    if (value >= .75) {
      return Colors.red;
    }

    if (value >= .45) {
      return Colors.orange;
    }

    return Colors.green;
  }

  IconData _getIcon(String packageName) {

    if (packageName.contains("instagram")) {
      return Icons.camera_alt;
    }

    if (packageName.contains("youtube")) {
      return Icons.play_circle_fill;
    }

    if (packageName.contains("whatsapp")) {
      return Icons.chat;
    }

    if (packageName.contains("facebook")) {
      return Icons.facebook;
    }

    if (packageName.contains("twitter")) {
      return Icons.alternate_email;
    }

    if (packageName.contains("telegram")) {
      return Icons.send;
    }

    if (packageName.contains("linkedin")) {
      return Icons.work;
    }

    if (packageName.contains("chrome")) {
      return Icons.language;
    }

    if (packageName.contains("maps")) {
      return Icons.map;
    }

    if (packageName.contains("camera")) {
      return Icons.camera;
    }

    if (packageName.contains("spotify")) {
      return Icons.music_note;
    }

    if (packageName.contains("gmail")) {
      return Icons.mail;
    }

    return Icons.apps;
  }
}