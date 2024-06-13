import 'package:flutter/material.dart';
import 'package:sudoku_dart/sudoku_dart.dart';
import 'package:sudoku_game/models/numberModel.dart';

class GameView extends StatefulWidget {
  final String gameLevel;

  const GameView({Key? key, required this.gameLevel}) : super(key: key);

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  late List<List<NumberModel>> puzzle;

  @override
  void initState() {
    super.initState();
    Level level = switchLevel(widget.gameLevel);
    Sudoku sudoku = Sudoku.generate(level);
    List<NumberModel> models = NumberModel.listToNumberModelList(sudoku.puzzle);
    puzzle = List.generate(9, (i) => models.sublist(i * 9, (i + 1) * 9));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.gameLevel.toUpperCase()),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(15),
          height: MediaQuery.of(context).size.height * 0.6,
          child: GridView.builder(
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 7,
              mainAxisSpacing: 7,
            ),
            itemBuilder: (context, index1) => buildGridRow(index1),
          ),
        ),
      ),
    );
  }

  Widget buildGridRow(int rowIndex) {
    return GridView.builder(
      itemCount: 9,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemBuilder: (context, index2) => buildNumberCard(rowIndex, index2),
    );
  }

  Widget buildNumberCard(int x, int y) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (puzzle[x][y].status == Type.notFixed) {
            puzzle[x][y].number = (puzzle[x][y].number == 9 || puzzle[x][y].number == -1) ? 1 : puzzle[x][y].number + 1;
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: (puzzle[x][y].status == Type.fixed) ? Colors.black26 : Colors.blue,
        ),
        child: Center(
          child: Text(
            (puzzle[x][y].number > 0 ? '${puzzle[x][y].number}' : ''),
            style: const TextStyle(fontSize: 25),
          ),
        ),
      ),
    );
  }

  Level switchLevel(String label) {
    switch (label.toLowerCase()) {
      case "easy":
        return Level.easy;
      case "medium":
        return Level.medium;
      case "hard":
        return Level.hard;
      default:
        return Level.expert;
    }
  }
}
