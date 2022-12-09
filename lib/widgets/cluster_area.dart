import 'package:flutter/material.dart';

import '../painters/cluster_area_painter.dart';

class ClusterArea extends StatelessWidget {
  final Offset? firstPoint;
  final Offset? lastPoint;
  const ClusterArea({this.firstPoint, this.lastPoint, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: CustomPaint(
        painter: ClusterAreaPainter(firstPoint, lastPoint),
      ),
    );
  }
}
