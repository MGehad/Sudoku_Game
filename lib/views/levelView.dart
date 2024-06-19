import 'package:flutter/material.dart';
import 'package:sudoku_game/appColors/appColors.dart';
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
  Sound music = Sound();

  @override
  void initState() {
    super.initState();
    music.playAndStopMusic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor.shade200,
        actions: [
          IconButton(
            onPressed: () {
              Sound.playSound();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsView(
                    sound: music,
                  ),
                ),
              );
            },
            icon: Icon(Icons.settings),
            color: AppColors.primaryColor,
          ),
        ],
      ),
      backgroundColor: AppColors.secondaryColor[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'SUDOKU',
              style: TextStyle(
                fontFamily: 'Chunq',
                color: AppColors.primaryColor,
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
