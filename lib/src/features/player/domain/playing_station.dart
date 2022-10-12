import 'package:equatable/equatable.dart';
import 'package:online_radio_player/src/features/stations/domain/station.dart';

class PlayingStation extends Station with EquatableMixin {
  final bool isPlaying;
  final List<String> metadata;

  PlayingStation({
    required Station station,
    this.isPlaying = false,
    this.metadata = const [],
  }) : super(
          id: station.id,
          name: station.name,
          imageUrl: station.imageUrl,
          streamUrl: station.imageUrl,
        );

  bool get _hasMetadata =>
      metadata.length >= 2 &&
      metadata.take(2).every((field) => field.isNotEmpty);

  String? get artist => _hasMetadata ? metadata[0] : null;
  String? get song => _hasMetadata ? metadata[1] : null;

  @override
  List<Object?> get props => [id, isPlaying, metadata];
}
