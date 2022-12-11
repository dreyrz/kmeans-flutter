import 'package:flutter/material.dart';
import 'package:kmeans/models/clustering_process.dart';

import '../painters/points_painter.dart';

class PointsTracer extends StatefulWidget {
  final ClusteringProcess data;
  const PointsTracer({required this.data, super.key});

  @override
  State<PointsTracer> createState() => _PointsTracerState();
}

class _PointsTracerState extends State<PointsTracer> {
  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: CustomPaint(
        size: Size(
          screenWidth,
          screenHeight,
        ),
        painter: PointsPainter(widget.data),
      ),
    );
  }
}
