import 'package:flutter/material.dart';
import 'package:kmeans/widgets/cartesian_plane.dart';

import 'widgets/random_points.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _pointsCount = 4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cartesian Plane"),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: const CartesianPlane(),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: RandomPoints(
              count: _pointsCount,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: const Text("Generate random points"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
