import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

class SmoothCard extends StatelessWidget {
  final double cornerRadius;
  final Widget child;
  const SmoothCard({Key? key, this.cornerRadius = 28, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: SmoothRectangleBorder(
        borderRadius: SmoothBorderRadius(
          cornerRadius: cornerRadius,
          cornerSmoothing: 1,
        ),
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: child,
      ),
    );
  }
}
