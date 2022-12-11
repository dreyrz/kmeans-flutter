import 'package:flutter/material.dart';
import 'package:kmeans/kmeans_visualizer.dart';

import 'widgets/button.dart';

class ValuesTaker extends StatefulWidget {
  const ValuesTaker({super.key});

  @override
  State<ValuesTaker> createState() => _ValuesTakerState();
}

class _ValuesTakerState extends State<ValuesTaker> {
  final _numberOfClustersController = TextEditingController();
  final _numberOfIterationsController = TextEditingController();
  final _numberOfPointsController = TextEditingController();

  @override
  void initState() {
    _numberOfPointsController.text = "20";
    _numberOfClustersController.text = "3";
    _numberOfIterationsController.text = "5";

    super.initState();
  }

  void _warn() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Valores inválidos'),
      duration: Duration(seconds: 1),
      backgroundColor: Colors.red,
    ));
  }

  void _navigate() {
    final nClusters = int.tryParse(_numberOfClustersController.text);
    final nIterations = int.tryParse(_numberOfIterationsController.text);
    final nPoints = int.tryParse(_numberOfPointsController.text);

    if (nClusters == null || nIterations == null || nPoints == null) {
      _warn();
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => KmeansVisualizer(
                numberOfClusters: nClusters,
                numberOfIterations: nIterations,
                numberOfPoints: nPoints,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Digite os valores a serem usados pelo K-means",
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _numberOfPointsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(),
                  labelText: "Número de pontos"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _numberOfIterationsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(),
                  labelText: "Número de iterações (k)"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _numberOfClustersController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(),
                  labelText: "Número de clusters"),
            ),
            const SizedBox(
              height: 10,
            ),
            Button(
              text: "Aplicar método",
              padding: EdgeInsets.zero,
              onPressed: _navigate,
            )
          ],
        ),
      ),
    );
  }
}
