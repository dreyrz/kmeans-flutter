import 'dart:math';

import 'package:flutter/material.dart';

import '../painters/random_points_painter.dart';
import '../utils/constants.dart';

class RandomPoints extends StatefulWidget {
  final int count;
  const RandomPoints({
    this.count = 100,
    super.key,
  });

  @override
  State<RandomPoints> createState() => _RandomPointsState();
}

class _RandomPointsState extends State<RandomPoints> {
  final _points = <Offset>[];

  @override
  void didUpdateWidget(a) {
    _randomPointsGenerator();
    super.didUpdateWidget(a);
  }

  void _randomPointsGenerator() {
    final random = Random();
    _points.clear();
    for (int i = 0; i < widget.count; i++) {
      final randomDx = random.nextInt(
        (screenWidth - Constants.cartesianPlaneOffset).toInt(),
      );
      final randomDy = random.nextInt(
        (screenHeight / 2 - 50).toInt(),
      );
      final randomPoint = Offset(randomDx.toDouble(), -randomDy.toDouble());
      // final randomPoint = Offset(0, -screenHeight / 2 + 50);
      debugPrint("Random point $randomPoint");
      _points.add(randomPoint);
    }
  }

  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(
        screenWidth,
        screenHeight,
      ),
      painter: RandomPointsPainter(_points),
    );
  }
}
