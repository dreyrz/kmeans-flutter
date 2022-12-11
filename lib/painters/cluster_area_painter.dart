import 'package:flutter/material.dart';
import 'package:kmeans/utils/math_utils.dart';

import '../utils/constants.dart';

class ClusterAreaPainter extends CustomPainter with MathUtils {
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
    canvas.translate(Constants.cartesianPlaneLeftPadding, size.height / 2);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeWidth = 1;
    final midPoint = calculateMidPoint(firstPoint!, lastPoint!);
    final radius = calculateCircleRadius(midPoint, lastPoint!);
    canvas.drawCircle(midPoint, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
