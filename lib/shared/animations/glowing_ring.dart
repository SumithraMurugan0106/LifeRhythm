import 'package:flutter/material.dart';

class GlowingRing extends StatefulWidget {
  final double size;

  const GlowingRing({
    super.key,
    this.size = 190,
  });

  @override
  State<GlowingRing> createState() => _GlowingRingState();
}

class _GlowingRingState extends State<GlowingRing>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: controller,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withValues(alpha: .55),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withValues(alpha: .30),
              blurRadius: 30,
              spreadRadius: 8,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}