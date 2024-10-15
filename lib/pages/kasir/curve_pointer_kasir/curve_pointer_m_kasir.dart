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

    path.moveTo(186, 10);
    path.quadraticBezierTo(186, 10, animValue3, 10);
    path.lineTo(animValue1, 10);
    path.quadraticBezierTo(animValue2, 10, animValue2, 30);
    path.lineTo(186, 30);
    path.close();

    path.moveTo(186, 50);
    path.quadraticBezierTo(186, 50, animValue3, 50);
    path.lineTo(animValue1, 50);
    path.quadraticBezierTo(animValue2, 50, animValue2, 30);
    path.lineTo(186, 30);
    path.close();

    paint.color = Colors.white;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
