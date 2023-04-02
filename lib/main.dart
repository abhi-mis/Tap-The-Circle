import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() => runApp(TapTheTarget());

class TapTheTarget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tap the Target',
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int _score = 0;
  int _timer = 30;
  Timer? _timerObj;
  Random _random = Random();
  double _top = 0;
  double _left = 0;

  void _startTimer() {
    _timerObj = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _timer -= 1;
      });
      if (_timer == 0) {
        _timerObj?.cancel();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Game Over!'),
              content: Text('Your score is $_score'),
              actions: [
                TextButton(
                  child: Text('Play Again'),
                  onPressed: () {
                    setState(() {
                      _score = 0;
                      _timer = 60;
                    });
                    Navigator.of(context).pop();
                    _startTimer();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  void _generateTarget() {
    _top = _random.nextInt(300).toDouble();
    _left = _random.nextInt(300).toDouble();
  }

  void _onTap() {
    setState(() {
      _score += 1;
    });
    _generateTarget();
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
    _generateTarget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tap the Target'),
      ),
      body: Center(
        child: Stack(
          children: [
            Positioned(
              top: _top,
              left: _left,
              child: GestureDetector(
                onTap: _onTap,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Text(
                'Score: $_score',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: Text(
                'Time: $_timer',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}