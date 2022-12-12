import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:kmeans/models/clustering_process.dart';
import 'package:kmeans/clustering_algorithms/kmeans.dart';
import 'package:kmeans/utils/list_utils.dart';
import 'package:kmeans/utils/points_utils.dart';
import 'package:kmeans/widgets/cartesian_plane.dart';
import 'widgets/points_tracer.dart';

class KmeansVisualizer extends StatefulWidget {
  final int numberOfClusters;
  final int numberOfIterations;
  final int numberOfPoints;

  const KmeansVisualizer({
    this.numberOfClusters = 3,
    this.numberOfIterations = 10,
    this.numberOfPoints = 20,
    super.key,
  });

  @override
  State<KmeansVisualizer> createState() => _KmeansVisualizerState();
}

class _KmeansVisualizerState extends State<KmeansVisualizer>
    with ListUtils, OffsetUtils {
  late Kmeans kmeans;

  final controller = StreamController<ClusteringProcess>();

  List<Offset> _points = [];
  int _currentIteration = 0;
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _generatePoints();
    });
    super.initState();
  }

  void _applyKmeans() {
    kmeans = Kmeans(_points, widget.numberOfClusters);
    kmeans.stream.listen(_clusteringListener);
    kmeans.apply(context.size!, iterations: widget.numberOfIterations);
  }

  void _generatePoints() {
    _points =
        randomPointsGenerator(context.size!, count: widget.numberOfPoints);
    _applyKmeans();
  }

  void _clusteringListener(ClusteringProcess data) {
    controller.add(data);
    if (data.iteration != null) {
      setState(() {
        _currentIteration = data.iteration!;
      });
    }
  }

  @override
  void dispose() {
    kmeans.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cartesian Plane"),
      ),
      body: Stack(
        children: [
          const CartesianPlane(),
          StreamBuilder<ClusteringProcess>(
              stream: controller.stream,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const SizedBox();
                }

                return PointsTracer(data: snapshot.data!);
              }),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(child: Text("Current iteration $_currentIteration")),
          )
        ],
      ),
    );
  }
}
