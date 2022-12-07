import 'dart:ui';

import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CartesianPlanePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(Constants.cartesianPlaneOffset, size.height / 2);
    // debugPrint("Size: $size");
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeWidth = 1;
    final points = _handleCartesianPlanePoints(canvas, size);
    debugPrint("last X axis point ${points.first.last.dx}");
    debugPrint("last Y axis point ${points.last.last.dy}");
    canvas.drawPoints(PointMode.polygon, points.first, paint);
    canvas.drawPoints(PointMode.polygon, points.last, paint);
  }

  void _drawText(Canvas canvas, Size size, Offset point) {
    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 8,
      fontWeight: FontWeight.bold,
    );

    String text = point.dx == 0 || point.dx == -20
        ? point.dy.toString()
        : point.dx.toString();
    text = text.substring(0, text.lastIndexOf('.')).replaceAll('-', '');

    final span = TextSpan(text: text, style: textStyle);
    final textPainter = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    final dy = point.dy == 0 ? point.dy + 4 : point.dy - 4;
    point = Offset(point.dx, dy);

    textPainter.paint(canvas, point);
  }

  void _drawOppositeLine(Canvas canvas, Offset point) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeWidth = 1;
    const lineLength = 4;
    if (point.dx == 0 && point.dy == 0) {
      return;
    }
    if (point.dx == 0) {
      final p1 = (Offset(point.dx - lineLength, point.dy));
      final p2 = (Offset(point.dx + lineLength, point.dy));
      canvas.drawLine(p1, p2, paint);
    } else if (point.dy == 0) {
      final p1 = (Offset(point.dx, point.dy - lineLength));
      final p2 = (Offset(point.dx, point.dy + lineLength));
      canvas.drawLine(p1, p2, paint);
    }
  }

  List<List<Offset>> _handleCartesianPlanePoints(Canvas canvas, Size size) {
    final xPoints = <Offset>[];
    final yPoints = <Offset>[];
    for (int i = 0; i < size.width; i++) {
      final value = Offset(i.toDouble(), 0);
      if (i % 20 == 0) {
        _drawText(canvas, size, value);
        _drawOppositeLine(canvas, value);
      }
      xPoints.add(value);
    }
    for (int j = 0; j < size.height; j++) {
      final value = Offset(0, j.toDouble());
      if (j % 20 == 0) {
        if (value.dy != 0) {
          _drawText(canvas, size, Offset((-value.dx) - 20, -value.dy));
        }

        _drawOppositeLine(canvas, -value);
      }
      yPoints.add(-value);
    }

    return [xPoints, yPoints];
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
