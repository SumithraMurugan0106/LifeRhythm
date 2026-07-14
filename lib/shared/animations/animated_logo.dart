import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedLogo extends StatelessWidget {
  final double size;

  const AnimatedLogo({
    super.key,
    this.size = 150,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/logo.png",
      width: size,
      height: size,
    )
        .animate()
        .fade(
      duration: 700.ms,
    )
        .scale(
      begin: const Offset(.6, .6),
      end: const Offset(1, 1),
      curve: Curves.easeOutBack,
      duration: 900.ms,
    );
  }
}