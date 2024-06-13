import 'package:flutter/material.dart';
import 'package:sudoku_game/views/levelView.dart';

class HomeView extends StatelessWidget {
  static const String id = 'home_view';

  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, LevelView.id);
              },
              child: Text(
                "Start",
                style: TextStyle(fontSize: 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
