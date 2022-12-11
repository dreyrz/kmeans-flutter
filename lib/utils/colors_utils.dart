import 'dart:math';

import 'package:flutter/material.dart';

mixin ColorUtils {
  List<MaterialColor> colors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.blueGrey,
  ];

  Color getRandomColor({Random? random}) {
    random ??= Random();

    final index = random.nextInt(colors.length);

    return colors.removeAt(index);
  }
}
