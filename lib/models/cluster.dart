import 'dart:ui';

class Cluster {
  final List<Offset> points;
  Offset centroid;
  Color color;
  Cluster(this.points, this.centroid, this.color);

  factory Cluster.empty(Offset centroid, Color color) =>
      Cluster([], centroid, color);

  void addPoint(Offset point) {
    points.add(point);
  }

  void changeCentroid(Offset newCentroid) {
    centroid = newCentroid;
  }

  Offset estimateMeanPoint() {
    if (points.isEmpty) {
      return centroid;
    }
    double sumX = 0;
    double sumY = 0;
    for (final point in points) {
      sumX += point.dx;
      sumY += point.dy;
    }

    double meanX = sumX / points.length;
    double meanY = sumY / points.length;
    return Offset(meanX, meanY);
  }

  @override
  String toString() => '\nCluster centroid: $centroid points $points\n';
}
