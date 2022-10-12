import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:online_radio_player/src/common_widgets/smooth_card.dart';

class StationLoadingCard extends StatelessWidget {
  const StationLoadingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.topCenter,
      child: SmoothCard(
        child: LoadingImage(),
      ),
    );
  }
}

class LoadingImage extends StatelessWidget {
  const LoadingImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.secondaryContainer;
    return Container(color: color)
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 1.seconds);
  }
}
