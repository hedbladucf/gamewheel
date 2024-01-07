import 'package:flutter/material.dart';
import 'package:gamewheel/game_wheel.dart';

void main() {
  runApp(const GameWheelApp());
}

class GameWheelApp extends StatelessWidget {
  const GameWheelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GameWheel',
      theme: ThemeData(
        fontFamily: 'Genos',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff011C3C),
        ),
      ),
      home: const GameWheel(),
      debugShowCheckedModeBanner: false,
    );
  }
}
