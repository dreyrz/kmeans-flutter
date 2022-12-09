import 'package:flutter/material.dart';

import '../painters/cartesian_plane_painter.dart';

class CartesianPlane extends StatelessWidget {
  const CartesianPlane({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: RepaintBoundary(
        child: CustomPaint(
          size: Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height,
          ),
          painter: CartesianPlanePainter(),
        ),
      ),
    );
  }
}
