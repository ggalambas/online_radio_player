import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_radio_player/src/features/player/presentation/mini_station_image.dart';
import 'package:online_radio_player/src/features/player/presentation/player.dart';
import 'package:online_radio_player/src/features/player/presentation/player_artwork.dart';

import 'player_controller.dart';

class PlayerScreen extends ConsumerWidget {
  const PlayerScreen({Key? key}) : super(key: key);

  ImageProvider get placeholder => const AssetImage('assets/placeholder.webp');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final artworkValue = ref.watch(artworkProvider);
    final station = ref.watch(playerControllerProvider).value!;
    return DecoratedBox(
      decoration: artworkValue.maybeWhen(
        orElse: () => BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
        data: (artwork) => BoxDecoration(
          image: DecorationImage(
            image: artwork,
            fit: BoxFit.cover,
          ),
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: MiniStationImage(station),
          ),
          body: Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: const PlayerArtwork(),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(32),
            child: Player(station),
          ),
        ),
      ),
    );
  }
}
