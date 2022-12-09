import 'package:flutter/material.dart';

import '../painters/random_points_painter.dart';

typedef RandomPointsCallback = void Function(List<Offset>);

class RandomPoints extends StatefulWidget {
  final List<Offset> points;
  const RandomPoints({required this.points, super.key});

  @override
  State<RandomPoints> createState() => _RandomPointsState();
}

class _RandomPointsState extends State<RandomPoints> {
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
        painter: RandomPointsPainter(widget.points),
      ),
    );
  }
}
