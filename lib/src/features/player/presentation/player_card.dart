import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_radio_player/src/common_widgets/smooth_card.dart';
import 'package:online_radio_player/src/features/player/presentation/player.dart';
import 'package:online_radio_player/src/features/player/presentation/player_artwork.dart';
import 'package:online_radio_player/src/features/stations/presentation/station_card/station_error_card.dart';
import 'package:online_radio_player/src/features/stations/presentation/station_card/station_loading_card.dart';

import 'mini_station_image.dart';
import 'player_controller.dart';

class PlayerCard extends ConsumerWidget {
  const PlayerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stationValue = ref.watch(playerControllerProvider);
    return SmoothCard(
      cornerRadius: 56,
      child: stationValue.when(
          loading: () => const LoadingImage(),
          error: (error, stackTrace) => const ErrorImage(),
          data: (station) {
            return Stack(
              children: [
                PlayerArtwork(
                  onTap: () {
                    ref
                        .read(playerControllerProvider.notifier)
                        .changeRadio(station);
                    Navigator.pushNamed(context, '/player');
                  },
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.topCenter,
                  child: MiniStationImage(station),
                ),
                Positioned.fill(
                  top: null,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black, Colors.transparent],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Player(station),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
