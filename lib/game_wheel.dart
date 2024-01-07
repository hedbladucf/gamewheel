import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

const _golfWithFriends = 'Golf with Friends';

const _games = [
  'Fortnite',
  'Jackbox',
  'Geoguessr',
  _golfWithFriends,
  'Overcooked',
  'Overwatch',
  'What do you Meme?',
];

const _boldWhite = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

const _duration = Duration(seconds: 4);

class GameWheel extends StatefulWidget {
  const GameWheel({super.key});

  @override
  State<GameWheel> createState() => _GameWheelState();
}

class _GameWheelState extends State<GameWheel> {
  late final StreamSubscription<int> _selectedSub;
  final _selected = StreamController<int>.broadcast();

  var _selectedItem = '';
  var _isGolfMode = false;

  @override
  void initState() {
    super.initState();
    _selectedSub = _selected.stream.listen(_onListen);
    _selected.add(Fortune.randomInt(0, _games.length));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Game Wheel',
          style: _boldWhite,
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        width: double.infinity,
        color: const Color.fromARGB(255, 11, 59, 98),
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            SizedBox(
              height: 400,
              child: FortuneWheel(
                duration: _duration,
                selected: _selected.stream,
                onFling: _onWheelFling,
                items: [
                  for (var game in _games)
                    FortuneItem(
                      child: Text(
                        game,
                        style: _boldWhite,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton.icon(
              onPressed: _onWheelFling,
              label: const Text(
                'Spin the Wheel',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              icon: const Icon(Icons.rotate_left_rounded),
            ),
            Container(
              margin: const EdgeInsets.all(30),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white),
              ),
              child: Text(
                _selectedItem,
                style: _boldWhite.copyWith(fontSize: 20),
              ),
            ),
            const Spacer(),
            SwitchListTile.adaptive(
              value: _isGolfMode,
              title: const Text(
                'Golf Mode',
                style: _boldWhite,
              ),
              subtitle: Text(
                _isGolfMode
                    ? "Looks like we're playing golf."
                    : "Come on, let's play some golf.",
                style: _boldWhite.copyWith(fontSize: 12),
              ),
              onChanged: (v) => setState(() => _isGolfMode = v),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onListen(int index) async {
    setState(() => _selectedItem = 'Spinning...');
    await Future.delayed(_duration);
    setState(() => _selectedItem = _games[index]);
  }

  void _onWheelFling() {
    final number = _isGolfMode
        ? _games.indexOf(_golfWithFriends)
        : Fortune.randomInt(0, _games.length);

    _selected.add(number);
  }

  @override
  void dispose() {
    _selectedSub.cancel();
    _selected.close();
    super.dispose();
  }
}
