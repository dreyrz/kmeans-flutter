import 'dart:math';

import 'package:flutter/material.dart';

import 'constants.dart';

mixin OffsetUtils {
  List<Offset> randomPointsGenerator(
    Size size, {
    Random? random,
    int count = 2,
  }) {
    random ??= Random();

    final List<Offset> points = [];
    final screenWidth = size.width;
    final screenHeight = size.height;

    const cartesianPlaneOffset = Constants.cartesianPlaneLeftPadding;

    for (int i = 0; i < count; i++) {
      final dxLimit = (screenWidth - cartesianPlaneOffset).toInt();
      final dyLimit =
          (screenHeight * Constants.cartesianPlaneHeightFactor - 50).toInt();

      final randomDx = random.nextInt(dxLimit);
      final randomDy = random.nextInt(dyLimit);

      final randomPoint = Offset(randomDx.toDouble(), -randomDy.toDouble());
      points.add(randomPoint);
    }
    return points;
  }
}
