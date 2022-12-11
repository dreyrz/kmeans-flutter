import 'dart:ui';

import 'cluster.dart';

class ClusteringProcess {
  final int? currentIteration;
  final List<Offset> points;
  final List<Offset>? previewsCentroids;
  final List<Offset>? centroids;
  final Offset? highlightPoint;
  final List<Cluster>? currentClusters;

  ClusteringProcess(
    this.points,
    this.currentIteration,
    this.previewsCentroids,
    this.centroids,
    this.currentClusters,
    this.highlightPoint,
  );
  bool get hasPreviewsCentroids =>
      previewsCentroids != null && previewsCentroids!.isNotEmpty;
  bool get hasCentroids => centroids != null && centroids!.isNotEmpty;
  bool get hasHighlightPoint => highlightPoint != null;
  bool get hasClusters =>
      currentClusters != null && currentClusters!.isNotEmpty;
}
