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
    // Since the canvas in the CartesianPlanePainter class
    // was translated by this offset
    canvas.translate(
      Constants.cartesianPlaneLeftPadding,
      size.height * Constants.cartesianPlaneHeightFactor,
    );
    _paintPoints(data.points, canvas);

    if (data.hasPreviewsCentroids) {
      _erasePreviewsCentroids(data.previewsCentroids!, canvas);
    }
    if (data.hasCentroids) {
      // debugPrint("PAINTING CENTROIDS");
      _paintCentroids(data.centroids!, canvas);
    }

    if (data.hasClusters) {
      // debugPrint("PAINTING CLUSTERS");
      for (final cluster in data.currentClusters!) {
        _paintClusterPoints(cluster, canvas);
      }
    }

    if (data.hasHighlightPoint) {
      // debugPrint("PAINTING HIGHLIGHTPOINTS");
      _paintPointHighlight(data.highlightPoint!, canvas);
    }
  }

  void _paintPoints(List<Offset> points, Canvas canvas) {
    final pointPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeWidth = 3;
    canvas.drawPoints(PointMode.points, points, pointPaint);
  }

  void _paintClusterPoints(Cluster cluster, Canvas canvas) {
    final pointPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = cluster.color
      ..strokeWidth = 8;
    canvas.drawPoints(PointMode.points, cluster.points, pointPaint);
  }

  void _paintCentroids(List<Offset> centroids, Canvas canvas) {
    final centroidPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeWidth = 8;
    canvas.drawPoints(PointMode.points, centroids, centroidPaint);
  }

  void _paintPointHighlight(Offset highlightPoint, Canvas canvas) {
    final highlightPointPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.red
      ..strokeWidth = 10;
    canvas.drawPoints(PointMode.points, [highlightPoint], highlightPointPaint);
  }

  void _erasePreviewsCentroids(List<Offset> centroids, Canvas canvas) {
    final eraser = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.white
      ..strokeWidth = 8;
    canvas.drawPoints(PointMode.points, centroids, eraser);
  }

  @override
  bool shouldRepaint(PointsPainter oldDelegate) =>
      oldDelegate.data.centroids != data.centroids ||
      oldDelegate.data.currentClusters != data.currentClusters ||
      oldDelegate.data.highlightPoint != data.highlightPoint;
}
