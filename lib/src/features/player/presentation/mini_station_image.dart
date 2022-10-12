import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_radio_player/src/common_widgets/smooth_card.dart';
import 'package:online_radio_player/src/features/stations/domain/station.dart';
import 'package:online_radio_player/src/features/stations/presentation/station_card/station_error_card.dart';
import 'package:online_radio_player/src/features/stations/presentation/station_card/station_loading_card.dart';

class MiniStationImage extends StatelessWidget {
  final Station station;
  const MiniStationImage(this.station, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'mini-station-image',
      child: SizedBox.square(
        dimension: kToolbarHeight - 16,
        child: SmoothCard(
          cornerRadius: 14,
          child: station.imageUrl.isEmpty
              ? const ErrorImage()
              : CachedNetworkImage(
                  imageUrl: station.imageUrl,
                  fit: BoxFit.contain,
                  errorWidget: (context, url, error) => const ErrorImage(),
                  placeholder: (context, url) => const LoadingImage(),
                ),
        ),
      ),
    );
  }
}
