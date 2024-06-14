/*Este widget pinta la linea de en medio de la pantalla*/

import 'package:flutter/material.dart';

class VerticalLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    paint.color = const Color.fromARGB(55, 100, 100, 100); // color of the line
    paint.strokeWidth = 2; // thickness of the line

    final double centerX = size.width / 2; // x-coordinate of the center
    const double startY = 0; // start y-coordinate of the line
    final double endY = size.height; // end y-coordinate of the line

    canvas.drawLine(
      Offset(centerX, startY),
      Offset(centerX, endY),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
