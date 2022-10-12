import 'package:flutter/material.dart';
import 'package:online_radio_player/src/common_widgets/smooth_card.dart';

class StationErrorCard extends StatelessWidget {
  const StationErrorCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.topCenter,
      child: SmoothCard(
        child: ErrorImage(),
      ),
    );
  }
}

class ErrorImage extends StatelessWidget {
  const ErrorImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSecondaryContainer;
    return Icon(Icons.radio, size: 32, color: color);
  }
}
