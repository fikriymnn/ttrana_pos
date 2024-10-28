// Painter untuk menggambar background melengkung
import 'package:flutter/material.dart';

class CurvePointerMKasir extends CustomPainter {
  final double animValue1;
  final double animValue2;
  final double animValue3;

  CurvePointerMKasir({
    required this.animValue1,
    required this.animValue2,
    required this.animValue3,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();

    path.moveTo(189, 5);
    path.quadraticBezierTo(189, 5, animValue3, 5);
    path.lineTo(animValue1, 5);
    path.quadraticBezierTo(animValue2, 5, animValue2, 25);
    path.lineTo(189, 25);
    path.close();

    path.moveTo(189, 40);
    path.quadraticBezierTo(189, 40, animValue3, 40);
    path.lineTo(animValue1, 40);
    path.quadraticBezierTo(animValue2, 40, animValue2, 25);
    path.lineTo(189, 25);
    path.close();

    paint.color = Colors.white;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
