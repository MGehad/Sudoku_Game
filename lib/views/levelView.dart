import 'package:flutter/material.dart';
import 'package:sudoku_game/views/gameView.dart';
import 'package:sudoku_game/widgets/sudokuButton.dart';

class LevelView extends StatelessWidget {
  const LevelView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        actions: [
          IconButton(
            onPressed: () {},
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
            SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}
