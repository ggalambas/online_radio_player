import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_radio_player/src/common_widgets/smooth_card.dart';
import 'package:online_radio_player/src/features/player/presentation/player_controller.dart';
import 'package:online_radio_player/src/features/stations/domain/station.dart';
import 'package:online_radio_player/src/features/stations/presentation/station_card/station_error_card.dart';
import 'package:online_radio_player/src/features/stations/presentation/station_card/station_loading_card.dart';
import 'package:online_radio_player/src/utils/string_zwsp.dart';

class StationCard extends ConsumerWidget {
  final Station station;
  const StationCard(this.station, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SmoothCard(
          child: InkWell(
            onTap: () {
              ref.read(playerControllerProvider.notifier).changeRadio(station);
              Navigator.pushNamed(context, '/player');
            },
            child: station.imageUrl.isEmpty
                ? const ErrorImage()
                : CachedNetworkImage(
                    imageUrl: station.imageUrl,
                    errorWidget: (context, url, error) => const ErrorImage(),
                    placeholder: (context, url) => const LoadingImage(),
                    imageBuilder: (context, imageProvider) => Ink.image(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              station.name.useCorrectEllipsis(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
