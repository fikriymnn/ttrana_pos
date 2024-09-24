// Painter untuk menggambar background melengkung
import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter {
  final double animValue1;
  final double animValue2;
  final double animValue3;

  CurvePainter({
    required this.animValue1,
    required this.animValue2,
    required this.animValue3,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();

    path.moveTo(300, 10);
    path.quadraticBezierTo(300, 10, animValue3, 10);
    path.lineTo(animValue1, 10);
    path.quadraticBezierTo(animValue2, 10, animValue2, 40);
    path.lineTo(300, 40);
    path.close();

    path.moveTo(300, 65);
    path.quadraticBezierTo(300, 65, animValue3, 65);
    path.lineTo(animValue1, 65);
    path.quadraticBezierTo(animValue2, 65, animValue2, 40);
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
