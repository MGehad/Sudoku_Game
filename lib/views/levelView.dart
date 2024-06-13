import 'package:flutter/material.dart';
import 'package:sudoku_game/widgets/levelButton.dart';

class LevelView extends StatelessWidget {
  static const String id = 'level_view';

  const LevelView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LevelButton(
              label: "Easy",
            ),
            SizedBox(
              height: 40,
            ),
            LevelButton(
              label: "Medium",
            ),
            SizedBox(
              height: 40,
            ),
            LevelButton(
              label: "Hard",
            ),
            SizedBox(
              height: 40,
            ),
            LevelButton(
              label: "Expert",
            ),
          ],
        ),
      ),
    );
  }
}
