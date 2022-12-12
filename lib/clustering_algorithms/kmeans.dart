import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kmeans/clustering_algorithms/clustering_algorithm.dart';
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
  List<Cluster> _clusters = [];

  @override
  Future<void> apply(Size size, {int iterations = 4}) async {
    _centroids = randomPointsGenerator(size, count: k);

    await _createClusters();

    for (int i = 0; i < iterations; i++) {
      await _streamData(iteration: i + 1);
      await _assignClusterToPoint();

      if (i < iterations - 1) {
        _repositionCentroids();
      }
    }
    log("Kmeans completed");
    await _streamData(previewsCentroids: _centroids, clusters: _clusters);
    cancel();
  }

  @override
  void cancel() {
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
    int delayInMillisSeconds = 10000 ~/ points.length;

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
    await Future.delayed(Duration(milliseconds: delayInMillisSeconds));
  }

  Future<void> _createClusters() async {
    log("Creating clusters");
    List<Cluster> clusters = [];
    for (final centroid in _centroids) {
      final randomColor = getRandomColor();
      final cluster = Cluster.empty(centroid, randomColor);
      clusters.add(cluster);
    }
    await _streamData(centroids: _centroids, clusters: clusters);
    _clusters = clusters;
  }

  Offset _defineNearestCentroid(Offset point) {
    late Offset nearestCentroid;
    double? distance;
    for (final centroid in _centroids) {
      final euclideanDist = calculateEuclideanDistance(point, centroid);
      if (distance == null || euclideanDist < distance) {
        distance = euclideanDist;
        nearestCentroid = centroid;
      }
    }
    return nearestCentroid;
  }

  void _removePointFromCluster(Offset point) {
    final index = _clusters.indexWhere((e) {
      return e.points.contains(point);
    });
    if (index != -1) {
      _clusters[index].removePoint(point);
    }
  }

  Future<void> _assignClusterToPoint() async {
    log("Assigning clusters to points");
    for (final point in points) {
      await _streamData(
        centroids: _centroids,
        point: point,
        clusters: _clusters,
      );
      final nearestCentroid = _defineNearestCentroid(point);
      final index = _clusters.indexWhere((e) {
        return e.centroid == nearestCentroid;
      });
      if (index == -1) {
        return;
      }

      _removePointFromCluster(point);

      _clusters[index].addPoint(point);
      _streamData(
        centroids: _centroids,
        clusters: _clusters,
      );
    }
  }

  Future<void> _repositionCentroids() async {
    log("Repositioning centroids");
    await _streamData(previewsCentroids: _centroids, clusters: _clusters);
    final centroids = <Offset>[];
    for (final cluster in _clusters) {
      final newCentroid = cluster.estimateMeanPoint();

      centroids.add(newCentroid);
      cluster.changeCentroid(newCentroid);
    }
    _centroids = centroids;

    await _streamData(centroids: centroids, clusters: _clusters);
  }
}
