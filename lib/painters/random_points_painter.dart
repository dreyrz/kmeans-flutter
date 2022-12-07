import 'dart:ui';

import 'package:flutter/material.dart';

import '../utils/constants.dart';

class RandomPointsPainter extends CustomPainter {
  final List<Offset> randomPoints;

  RandomPointsPainter(this.randomPoints);

  @override
  void paint(Canvas canvas, Size size) {
    // Since the canvas in the _CartesianPlanePainter class
    // was translated 40 pixels
    canvas.translate(Constants.cartesianPlaneOffset, size.height / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.red
      ..strokeWidth = 5;

    canvas.drawPoints(PointMode.points, randomPoints, paint);
  }

  @override
  bool shouldRepaint(covariant RandomPointsPainter oldDelegate) => false;
}
