import 'dart:math';
import 'dart:ui';

mixin MathUtils {
  Offset calculateMidPoint(Offset p1, Offset p2) {
    final midX = (p1.dx + p2.dx) / 2;
    final midY = (p1.dy + p2.dy) / 2;
    return Offset(midX, midY);
  }

  double calculateCircleRadius(
    Offset center,
    Offset point,
  ) {
    final powX = pow(center.dx - point.dx, 2);
    final powY = pow(center.dy - point.dy, 2);
    final squareDist = powX + powY;

    return sqrt(squareDist);
  }

  double calculateEuclideanDistance(Offset p1, Offset p2) {
    return sqrt(pow((p2.dx - p1.dx), 2) + pow((p2.dy - p1.dy), 2));
  }
}
