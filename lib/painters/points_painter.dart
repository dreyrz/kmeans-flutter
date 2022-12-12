import 'dart:ui';

import 'package:flutter/material.dart';

import '../models/cluster.dart';
import '../models/clustering_process.dart';
import '../utils/constants.dart';

class PointsPainter extends CustomPainter {
  final ClusteringProcess data;

  PointsPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final centroidPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.square;
    // Since the canvas in the CartesianPlanePainter class
    // was translated by this offset
    canvas.translate(
      Constants.cartesianPlaneLeftPadding,
      size.height * Constants.cartesianPlaneHeightFactor,
    );
    _paintPoints(data.points, canvas);

    if (data.hasPreviewsCentroids) {
      _erasePreviewsCentroids(data.previewsCentroids!, canvas, centroidPaint);
    }
    if (data.hasCentroids) {
      _paintCentroids(data.centroids!, canvas, centroidPaint);
    }

    if (data.hasClusters) {
      for (final cluster in data.clusters!) {
        _paintClusterPoints(cluster, canvas);
      }
    }

    if (data.hasHighlightPoint) {
      _paintPointHighlight(data.highlightPoint!, canvas);
      _drawDistLine(data.centroids!, data.highlightPoint!, canvas);
    }
  }

  void _paintPoints(List<Offset> points, Canvas canvas) {
    final pointPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(PointMode.points, points, pointPaint);
  }

  void _paintClusterPoints(Cluster cluster, Canvas canvas) {
    final pointPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = cluster.color
      ..strokeWidth = 4
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    canvas.drawPoints(PointMode.points, cluster.points, pointPaint);
  }

  void _paintCentroids(
      List<Offset> centroids, Canvas canvas, Paint centroidPaint) {
    canvas.drawPoints(PointMode.points, centroids, centroidPaint);
  }

  void _paintPointHighlight(Offset highlightPoint, Canvas canvas) {
    final highlightPointPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.red
      ..strokeWidth = 2;

    canvas.drawCircle(highlightPoint, 10, highlightPointPaint);
  }

  void _erasePreviewsCentroids(
      List<Offset> centroids, Canvas canvas, Paint centroidPaint) {
    final eraser = centroidPaint..color = Colors.white;
    canvas.drawPoints(PointMode.points, centroids, eraser);
  }

  void _drawDistLine(List<Offset> centroids, Offset point, Canvas canvas) {
    final linePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 1;
    for (final centroid in centroids) {
      canvas.drawLine(point, centroid, linePaint);
    }
  }

  @override
  bool shouldRepaint(PointsPainter oldDelegate) =>
      oldDelegate.data.centroids != data.centroids ||
      oldDelegate.data.clusters != data.clusters ||
      oldDelegate.data.highlightPoint != data.highlightPoint;
}
