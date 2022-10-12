import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:online_radio_player/src/features/stations/domain/station.dart';

// http://all.api.radio-browser.info/

final stationsRepositoryProvider = Provider<StationsRepository>(
  (ref) => StationsRepository(),
);

const pageSize = 30;

class StationsRepository {
  //? returning a different value
  // Future<Station> fetchHottestStation() async {
  //   final response = await http.get(Uri.http(
  //     'all.api.radio-browser.info',
  //     '/json/stations',
  //     {
  //       'order': 'clickcount',
  //       'hidebroken': 'true',
  //       'limit': '1',
  //     },
  //   ));

  //   if (response.statusCode == 200) {
  //     return _decodeStations(response.body).first;
  //   } else {
  //     throw Exception('Failed to load radios');
  //   }
  // }

  Future<List<Station>> fetchStations(int page) async {
    final response = await http.get(Uri.http(
      'all.api.radio-browser.info',
      '/json/stations',
      {
        'order': 'clickcount',
        'hidebroken': 'true',
        'limit': '$pageSize',
        'offset': '${page * pageSize}',
      },
    ));

    if (response.statusCode == 200) {
      return compute(_decodeStations, response.body);
    } else {
      throw Exception('Failed to load radios');
    }
  }

  List<Station> _decodeStations(String encodedJson) {
    final decodedJson = jsonDecode(encodedJson) as List;
    final jsonData = decodedJson.cast<Map<String, dynamic>>();
    return jsonData.map((json) => Station.fromJson(json)).toList();
  }
}

final hottestStationFutureProvider = FutureProvider.autoDispose<Station>(
  (ref) async {
    final stations = await ref.watch(stationsFutureProvider(0).future);
    return stations.first;
  },
);

final stationsFutureProvider =
    FutureProvider.family.autoDispose<List<Station>, int>(
  (ref, page) {
    // if (page == 0) ref.keepAlive();
    final repository = ref.watch(stationsRepositoryProvider);
    return repository.fetchStations(page);
  },
);
