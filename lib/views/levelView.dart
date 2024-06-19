import 'package:flutter/material.dart';
import 'package:sudoku_game/sound/sound.dart';
import 'package:sudoku_game/views/gameView.dart';
import 'package:sudoku_game/views/settingsView.dart';
import 'package:sudoku_game/widgets/sudokuButton.dart';

class LevelView extends StatefulWidget {
  const LevelView({super.key});

  @override
  State<LevelView> createState() => _LevelViewState();

}

class _LevelViewState extends State<LevelView> {
  Sound sound = Sound();

  @override
  void initState() {
    super.initState();
    sound.playAndStopMusic();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        actions: [
          IconButton(
            onPressed: () {
              Sound.playSound();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsView(
                    sound: sound,
                  ),
                ),
              );
            },
            icon: Icon(Icons.settings),
            color: Colors.indigo,
          ),
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'SUDOKU',
              style: TextStyle(
                fontFamily: 'Chunq',
                color: Colors.indigo,
                fontSize: 70,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SudokuButton(
                  onPressed: () {
                    Sound.playSound();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameView(gameLevel: "Easy"),
                      ),
                    );
                  },
                  label: "Easy",
                ),
                const SizedBox(
                  height: 40,
                ),
                SudokuButton(
                  onPressed: () {
                    Sound.playSound();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameView(gameLevel: "Medium"),
                      ),
                    );
                  },
                  label: "Medium",
                ),
                const SizedBox(
                  height: 40,
                ),
                SudokuButton(
                  onPressed: () {
                    Sound.playSound();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameView(gameLevel: "Hard"),
                      ),
                    );
                  },
                  label: "Hard",
                ),
                const SizedBox(
                  height: 40,
                ),
                SudokuButton(
                  onPressed: () {
                    Sound.playSound();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameView(gameLevel: "Expert"),
                      ),
                    );
                  },
                  label: "Expert",
                ),
              ],
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
