import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_radio_player/src/features/player/presentation/player_card.dart';
import 'package:online_radio_player/src/features/stations/data/stations_repository.dart';

import 'hot_stations_title.dart';
import 'station_card/station_card.dart';
import 'station_card/station_error_card.dart';
import 'station_card/station_loading_card.dart';

class StationsScreen extends ConsumerStatefulWidget {
  const StationsScreen({super.key});

  @override
  ConsumerState<StationsScreen> createState() => _StationsScreenState();
}

class _StationsScreenState extends ConsumerState<StationsScreen>
    with SingleTickerProviderStateMixin {
  late final animationController = AnimationController(
    vsync: this,
    duration: Animate.defaultDuration,
  )..value = 1;
  late final sizeAnimation = CurvedAnimation(
    parent: animationController,
    curve: Animate.defaultCurve,
  );

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  int? itemCount;

  @override
  Widget build(BuildContext context) {
    final isHotExpanded = ref.watch(isHotExpandedProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radio stations'),
        actions: [
          if (isHotExpanded)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextButton(
                onPressed: () {
                  ref.read(isHotExpandedProvider.notifier).state = false;
                  animationController.forward();
                },
                child: const Text('See less'),
              ).animate().fadeIn(),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            FadeTransition(
              opacity: sizeAnimation,
              child: SizeTransition(
                sizeFactor: sizeAnimation,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: PlayerCard(),
                    ),
                    HotStationsTitle(
                      onExpanded: () => animationController.animateBack(0),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 4 / 5,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: isHotExpanded ? itemCount : 3,
                itemBuilder: (context, i) {
                  final page = i ~/ pageSize;
                  final offset = i % pageSize;
                  final stationsValue = ref.watch(stationsFutureProvider(page));

                  return stationsValue.when(
                    loading: () => const StationLoadingCard(),
                    error: (error, stackTrace) => const StationErrorCard(),
                    data: (stations) {
                      if (offset >= stations.length) {
                        Future.microtask(() => setState(() => itemCount = i));
                        return const SizedBox.shrink();
                      }
                      return StationCard(stations[offset]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
