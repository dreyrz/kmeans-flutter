import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final EdgeInsets? padding;
  final double height;

  const Button({
    required this.text,
    this.onPressed,
    this.padding,
    this.height = 60,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(8.0),
      child: SizedBox(
        height: height,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
