import 'package:flutter/material.dart';
import 'screens/game_filter_screen.dart';

void main() => runApp(const GameFilterApp());

class GameFilterApp extends StatelessWidget {
  const GameFilterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MMOBomb Games',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const GameFilterScreen(),
    );
  }
}
