import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:online_radio_player/src/features/player/domain/playing_station.dart';
import 'package:online_radio_player/src/features/player/presentation/player_controller.dart';

class Player extends ConsumerWidget {
  final PlayingStation station;
  const Player(this.station, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Hero(
      tag: 'player',
      child: Material(
        color: Colors.transparent,
        child: Row(
          children: [
            GlowButton(
              width: 64,
              height: 64,
              borderRadius: BorderRadius.circular(32),
              padding: EdgeInsets.zero,
              onPressed: () {
                final controller = ref.read(playerControllerProvider.notifier);
                station.isPlaying ? controller.pause() : controller.play();
              },
              child: Icon(
                station.isPlaying
                    ? Icons.pause_rounded
                    : Icons.play_arrow_rounded,
                size: 40,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    station.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  if (station.artist != null && station.song != null)
                    MarqueeText(
                      text: TextSpan(
                        text: '${station.artist} - ${station.song}',
                      ),
                      style: const TextStyle(
                        fontWeight: FontWeight.w100,
                        height: 1.3,
                      ),
                      speed: 15,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
