import 'package:flutter/material.dart';

import 'features/player/presentation/player_screen.dart';
import 'features/stations/presentation/stations_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radio Player',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.cyan,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const StationsScreen(),
        '/player': (_) => const PlayerScreen(),
      },
    );
  }
}
