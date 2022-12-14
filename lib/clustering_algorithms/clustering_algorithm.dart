import 'package:flutter/material.dart';

abstract class ClusteringAlgorithm<Process> {
  final List<Offset> points;

  ClusteringAlgorithm(this.points);

  Future<void> apply(Size size, {int iterations = 4});
  void cancel();

  Stream<Process> get stream;
}
