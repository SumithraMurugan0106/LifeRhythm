import 'package:flutter/material.dart';

class BackgroundCircles extends StatelessWidget {
  const BackgroundCircles({super.key});

  @override
  Widget build(BuildContext context) {

    return Stack(

      children: [

        Positioned(
          top: -40,
          left: -30,
          child: circle(170, Colors.white24),
        ),

        Positioned(
          right: -60,
          top: 120,
          child: circle(200, Colors.white30),
        ),

        Positioned(
          bottom: -70,
          left: 40,
          child: circle(180, Colors.white24),
        ),

        Positioned(
          bottom: 180,
          right: -50,
          child: circle(140, Colors.white24),
        ),

      ],

    );

  }

  Widget circle(double size, Color color) {

    return Container(

      width: size,

      height: size,

      decoration: BoxDecoration(

        shape: BoxShape.circle,

        color: color,

      ),

    );

  }

}