import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_radio_player/src/features/domain/playing_station.dart';
import 'package:online_radio_player/src/features/stations/data/stations_repository.dart';
import 'package:online_radio_player/src/features/stations/domain/station.dart';
import 'package:radio_player/radio_player.dart';

final artworkProvider = FutureProvider.autoDispose<ImageProvider>((ref) async {
  ref.watch(
      playerControllerProvider.select((station) => station.valueOrNull?.id));
  ref.watch(playerControllerProvider
      .select((station) => station.valueOrNull?.metadata));
  try {
    final artwork = await ref
        .watch(playerControllerProvider.notifier)
        .radioPlayer
        .getArtworkImage();
    return artwork!.image;
  } catch (_) {
    return const AssetImage('assets/placeholder.webp');
  }
});

final playerControllerProvider = StateNotifierProvider.autoDispose<
    PlayerController, AsyncValue<PlayingStation>>(
  (ref) {
    final hottest = ref.watch(hottestStationFutureProvider).valueOrNull;
    return PlayerController(station: hottest);
  },
);

class PlayerController extends StateNotifier<AsyncValue<PlayingStation>> {
  final radioPlayer = RadioPlayer();

  PlayerController({Station? station})
      : super(
          station == null
              ? const AsyncValue.loading()
              : AsyncValue.data(PlayingStation(station: station)),
        ) {
    if (station != null) changeRadio(station, play: false);
  }

  PlayingStation get _station => state.value!;
  set _station(PlayingStation station) => state = AsyncValue.data(station);

  void changeRadio(Station station, {bool play = true}) async {
    if (_station == station) return this.play();
    _station = PlayingStation(station: station);
    await stop();
    try {
      await radioPlayer.setChannel(
        title: station.name,
        url: station.streamUrl,
      );
      listenToState();
      listenToMetadata();
      if (play) this.play();
    } catch (_) {
      await stop();
    }
  }

  Future<void> stop() async {
    stateSub?.cancel();
    metadataSub?.cancel();
    if (state.hasValue) {
      _station = PlayingStation(
        station: _station,
        metadata: _station.metadata,
      );
    }
    await radioPlayer.stop();
  }

  void play() {
    try {
      if (!_station.isPlaying) radioPlayer.play();
    } catch (_) {
      changeRadio(_station);
    }
  }

  void pause() {
    if (_station.isPlaying) radioPlayer.pause();
  }

  @override
  void dispose() {
    stop();
    super.dispose();
  }

  // listeners

  StreamSubscription? stateSub;
  void listenToState() {
    stateSub?.cancel();
    stateSub = radioPlayer.stateStream.listen((isPlaying) {
      if (state.isLoading) return;
      _station = PlayingStation(
        station: _station,
        isPlaying: isPlaying,
        metadata: _station.metadata,
      );
    });
  }

  StreamSubscription? metadataSub;
  void listenToMetadata() {
    metadataSub?.cancel();
    metadataSub = radioPlayer.metadataStream.listen((metadata) {
      if (state.isLoading) return;
      _station = PlayingStation(
        station: _station,
        isPlaying: _station.isPlaying,
        metadata: metadata,
      );
    });
  }
}
