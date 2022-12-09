import 'dart:math';

import 'package:flutter/material.dart';

import 'constants.dart';

mixin PointsUtils {
  List<Offset> randomPointsGenerator(
    BuildContext context, {
    Random? random,
    int count = 2,
  }) {
    random ??= Random();

    final List<Offset> points = [];
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    const cartesianPlaneOffset = Constants.cartesianPlaneOffset;

    for (int i = 0; i < count; i++) {
      final dxLimit = (screenWidth - cartesianPlaneOffset).toInt();
      final dyLimit = (screenHeight / 2 - 50).toInt();

      final randomDx = random.nextInt(dxLimit);
      final randomDy = random.nextInt(dyLimit);

      final randomPoint = Offset(randomDx.toDouble(), -randomDy.toDouble());
      points.add(randomPoint);
    }
    return points;
  }
}
