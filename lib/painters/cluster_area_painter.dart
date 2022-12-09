import 'dart:math';

import 'package:flutter/material.dart';

import '../utils/constants.dart';

class ClusterAreaPainter extends CustomPainter {
  final Offset? firstPoint;
  final Offset? lastPoint;
  ClusterAreaPainter(this.firstPoint, this.lastPoint);
  @override
  void paint(Canvas canvas, Size size) {
    if (firstPoint == null || lastPoint == null) {
      return;
    }

    // Since the canvas in the CartesianPlanePainter class
    // was translated by this offset
    canvas.translate(Constants.cartesianPlaneOffset, size.height / 2);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeWidth = 1;
    final midPoint = _calculateMidPoint(firstPoint!, lastPoint!);
    final radius = _calculateRadiusToContainPoints(midPoint, lastPoint!);
    canvas.drawCircle(midPoint, radius, paint);
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
    final squareDist = powX + powY;

    return sqrt(squareDist);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
