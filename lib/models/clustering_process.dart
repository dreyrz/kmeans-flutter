import 'dart:ui';

import 'cluster.dart';

class ClusteringProcess {
  final int? iteration;
  final List<Offset> points;
  final List<Offset>? previewsCentroids;
  final List<Offset>? centroids;
  final Offset? highlightPoint;
  final List<Cluster>? clusters;

  ClusteringProcess(
    this.points,
    this.iteration,
    this.previewsCentroids,
    this.centroids,
    this.clusters,
    this.highlightPoint,
  );

  bool get hasPreviewsCentroids =>
      previewsCentroids != null && previewsCentroids!.isNotEmpty;
  bool get hasCentroids => centroids != null && centroids!.isNotEmpty;
  bool get hasHighlightPoint => highlightPoint != null;
  bool get hasClusters => clusters != null && clusters!.isNotEmpty;

  @override
  String toString() {
    return '''ClusteringProcess(iteration: $iteration, points: $points, 
    previewsCentroids: $previewsCentroids, centroids: $centroids, 
    highlightPoint: $highlightPoint, clusters: $clusters)''';
  }
}
