// Painter untuk menggambar background melengkung
import 'package:flutter/material.dart';

class CurvePointerTKasir extends CustomPainter {
  final double animValue1;
  final double animValue2;
  final double animValue3;

  CurvePointerTKasir({
    required this.animValue1,
    required this.animValue2,
    required this.animValue3,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();

    path.moveTo(300, 5);
    path.quadraticBezierTo(300, 5, animValue3, 5);
    path.lineTo(animValue1, 5);
    path.quadraticBezierTo(animValue2, 5, animValue2, 40);
    path.lineTo(300, 40);
    path.close();

    path.moveTo(300, 70);
    path.quadraticBezierTo(300, 70, animValue3, 70);
    path.lineTo(animValue1, 70);
    path.quadraticBezierTo(animValue2, 70, animValue2, 40);
    path.lineTo(300, 40);
    path.close();

    paint.color = Colors.white; // Warna untuk kurva
    canvas.drawPath(path, paint); // Gambar path
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this; // Repaint jika ada perubahan
  }
}
