import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'heartbeat_painter.dart';

class HeartBeatWidget extends StatelessWidget {
  const HeartBeatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 40,
      child: CustomPaint(
        painter: HeartBeatPainter(),
      ),
    )
        .animate(delay: 1700.ms)
        .fade(duration: 600.ms)
        .slideY(
      begin: .4,
      end: 0,
    );
  }
}