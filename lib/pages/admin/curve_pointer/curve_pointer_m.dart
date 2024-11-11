// Painter untuk menggambar background melengkung
import 'package:flutter/material.dart';

class CurvePainterM extends CustomPainter {
  final double animValue1;
  final double animValue2;
  final double animValue3;

  CurvePainterM({
    required this.animValue1,
    required this.animValue2,
    required this.animValue3,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();

    path.moveTo(200, 5);
    path.quadraticBezierTo(200, 5, animValue3, 5);
    path.lineTo(animValue1, 5);
    path.quadraticBezierTo(animValue2, 5, animValue2, 25);
    path.lineTo(200, 25);
    path.close();

    path.moveTo(200, 40);
    path.quadraticBezierTo(200, 40, animValue3, 40);
    path.lineTo(animValue1, 40);
    path.quadraticBezierTo(animValue2, 40, animValue2, 25);
    path.lineTo(200, 25);
    path.close();

    paint.color = Colors.white;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
