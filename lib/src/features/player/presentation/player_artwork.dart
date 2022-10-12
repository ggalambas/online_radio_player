import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_radio_player/src/common_widgets/smooth_card.dart';
import 'package:online_radio_player/src/features/player/presentation/player_controller.dart';
import 'package:online_radio_player/src/features/stations/presentation/station_card/station_loading_card.dart';

class PlayerArtwork extends ConsumerWidget {
  final VoidCallback? onTap;
  const PlayerArtwork({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final artworkValue = ref.watch(artworkProvider);
    return Hero(
      tag: 'player-artwork',
      child: SmoothCard(
        cornerRadius: 56,
        child: InkWell(
          onTap: onTap,
          child: artworkValue.maybeWhen(
            orElse: () => const LoadingImage(),
            data: (artwork) => Ink.image(
              image: artwork,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
