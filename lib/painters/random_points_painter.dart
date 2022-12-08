import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../utils/constants.dart';

class RandomPointsPainter extends CustomPainter {
  final List<Offset> randomPoints;

  RandomPointsPainter(this.randomPoints);

  @override
  void paint(Canvas canvas, Size size) {
    // Since the canvas in the CartesianPlanePainter class
    // was translated by this offset
    canvas.translate(Constants.cartesianPlaneOffset, size.height / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.red
      ..strokeWidth = 5;

    canvas.drawPoints(PointMode.points, randomPoints, paint);
    final paintCircle = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeWidth = 1;
    if (randomPoints.isEmpty) {
      return;
    }

    final p1 = randomPoints.first;
    final p2 = randomPoints.last;

    final midPoint = _calculateMidPoint(p1, p2);
    final radius = _calculateRadiusToContainPoints(midPoint, p2);
    canvas.drawCircle(midPoint, radius, paintCircle);
  }

  Offset _calculateMidPoint(Offset p1, Offset p2) {
    final midX = (p1.dx + p2.dx) / 2;
    final midY = (p1.dy + p2.dy) / 2;
    return Offset(midX, midY);
  }

  double _calculateRadiusToContainPoints(
    Offset center,
    Offset point,
  ) {
    final powX = pow(center.dx - point.dx, 2);
    final powY = pow(center.dy - point.dy, 2);
    final dist = powX + powY;

    return sqrt(dist);
  }

  @override
  bool shouldRepaint(covariant RandomPointsPainter oldDelegate) => false;
}
