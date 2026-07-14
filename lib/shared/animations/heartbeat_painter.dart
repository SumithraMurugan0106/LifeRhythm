import 'package:flutter/material.dart';

class HeartBeatPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 3
      ..color = Colors.white
      ..style = PaintingStyle.stroke;

    Path path = Path();

    path.moveTo(0, size.height / 2);

    path.lineTo(size.width * .25, size.height / 2);

    path.lineTo(size.width * .35, size.height * .15);

    path.lineTo(size.width * .45, size.height * .85);

    path.lineTo(size.width * .55, size.height * .3);

    path.lineTo(size.width * .65, size.height / 2);

    path.lineTo(size.width, size.height / 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}