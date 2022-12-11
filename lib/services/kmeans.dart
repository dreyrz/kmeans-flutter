import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kmeans/services/clustering_algorithm.dart';
import 'package:kmeans/utils/math_utils.dart';
import 'package:kmeans/utils/points_utils.dart';

import '../models/cluster.dart';
import '../models/clustering_process.dart';
import '../utils/colors_utils.dart';

class Kmeans extends ClusteringAlgorithm<ClusteringProcess>
    with OffsetUtils, MathUtils, ColorUtils {
  final int k;

  Kmeans(super.points, this.k);

  final _controller = StreamController<ClusteringProcess>();

  @override
  Stream<ClusteringProcess> get stream => _controller.stream;

  List<Offset> _centroids = [];

  @override
  Future<void> apply(Size size, {int iterations = 4}) async {
    _centroids = randomPointsGenerator(size, count: k);
    await _streamData(centroids: _centroids);

    List<Cluster> clusters = await _createClusters(_centroids);

    for (int i = 0; i < iterations; i++) {
      await _streamData(iteration: i + 1);
      await _definePointClusters(clusters, _centroids);

      if (i < iterations - 1) {
        _repositionCentroids(clusters);
      }
    }
    // log("final clusters \n$clusters");
    await _streamData(centroids: _centroids, clusters: clusters);
    dispose();
  }

  @override
  void dispose() {
    _controller.sink.close();
    _controller.close();
  }

  Future<void> _streamData({
    int? iteration,
    List<Offset>? previewsCentroids,
    List<Offset>? centroids,
    List<Cluster>? clusters,
    Offset? point,
  }) async {
    // log("Streaming data");
    final process = ClusteringProcess(
      points,
      iteration,
      previewsCentroids,
      centroids,
      clusters,
      point,
    );

    _controller.add(process);
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<List<Cluster>> _createClusters(List<Offset> centroids) async {
    log("Creating clusters");
    List<Cluster> clusters = [];
    for (final centroid in centroids) {
      final randomColor = getRandomColor();
      final cluster = Cluster.empty(centroid, randomColor);
      clusters.add(cluster);
    }
    // debugPrint("Clusters created:\n$clusters");
    await _streamData(centroids: centroids, clusters: clusters);
    return clusters;
  }

  Future<void> _definePointClusters(
    List<Cluster> clusters,
    List<Offset> randomCentroids,
  ) async {
    log("Assigning points");
    for (final point in points) {
      await _streamData(
        centroids: randomCentroids,
        point: point,
        clusters: clusters,
      );
      final nearestCentroid = _defineNearestCentroid(randomCentroids, point);
      // debugPrint("NEAREST ENTROID $nearestCentroid");
      final clusterIndex = clusters.indexWhere((e) {
        // debugPrint("Comparing");
        // debugPrint("cluster ${e.centroid} calculated $nearestCentroid");
        return e.centroid == nearestCentroid;
      });
      if (clusterIndex == -1) {
        // debugPrint("NAO ACHOU");
        return;
      }
      clusters[clusterIndex].addPoint(point);
      _streamData(
        centroids: randomCentroids,
        clusters: clusters,
      );
    }
  }

  Offset _defineNearestCentroid(List<Offset> centroids, Offset point) {
    late Offset nearestCentroid;
    double? distance;
    for (final centroid in centroids) {
      // debugPrint("Calculating for centroid $centroid");

      final euclideanDist = calculateEuclideanDistance(point, centroid);
      // debugPrint("distance $distance");
      // debugPrint("euclideanDist $euclideanDist for $centroid");
      if (distance == null) {
        distance = euclideanDist;
        nearestCentroid = centroid;
        // debugPrint("nearestCentroid FIRSTIF $nearestCentroid");
      } else if (euclideanDist < distance) {
        distance = euclideanDist;
        nearestCentroid = centroid;
        // debugPrint("nearestCentroid ELSEIF $nearestCentroid");
      }
    }
    // debugPrint("CENTROID $nearestCentroid FOR POINT $point");
    return nearestCentroid;
  }

  Future<void> _repositionCentroids(
    List<Cluster> clusters,
  ) async {
    log("Repositioning");
    await _streamData(previewsCentroids: _centroids, clusters: clusters);
    final centroids = <Offset>[];
    for (final cluster in clusters) {
      // debugPrint("Previews Centroids ${cluster.centroid}");
      final newCentroid = cluster.estimateMeanPoint();
      centroids.add(newCentroid);
      cluster.changeCentroid(newCentroid);
    }
    _centroids = centroids;
    // debugPrint("new Centroids $centroids");
    await _streamData(centroids: centroids, clusters: clusters);
  }
}
