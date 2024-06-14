import 'package:flutter/material.dart';
import 'package:sudoku_game/views/gameView.dart';

class LevelButton extends StatelessWidget {
  final String label;

  const LevelButton({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameView(
              gameLevel: label,
            ),
          ),
        );
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        padding: MaterialStateProperty.all(const EdgeInsets.all(16)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        )),
        elevation: MaterialStateProperty.all(4),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 36,
        ),
      ),
    );
  }
}
