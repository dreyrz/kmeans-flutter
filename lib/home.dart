import 'package:flutter/material.dart';
import 'package:kmeans/utils/list_utils.dart';
import 'package:kmeans/utils/points_utils.dart';
import 'package:kmeans/widgets/cartesian_plane.dart';
import 'package:kmeans/widgets/cluster_area.dart';

import 'widgets/button.dart';
import 'widgets/random_points.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with ListUtils, PointsUtils {
  List<Offset> _points = [];

  void _generatePoints() {
    _points = randomPointsGenerator(context);
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
          RandomPoints(points: _points),
          ClusterArea(
            firstPoint: firstOrNull(_points),
            lastPoint: lastOrNull(_points),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Button(
              onPressed: () {
                setState(() {
                  _generatePoints();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
