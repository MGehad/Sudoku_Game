import 'package:flutter/material.dart';
import 'package:sudoku_game/sound/sound.dart';
import 'package:sudoku_game/widgets/sudokuButton.dart';
import '../models/numberModel.dart';

class FinishView extends StatefulWidget {
  List<NumberModel> puzzle;
  List<int> solution;
  final int time;

  FinishView(
      {super.key,
      required this.puzzle,
      required this.time,
      required this.solution});

  @override
  State<FinishView> createState() => _FinishViewState();
}

class _FinishViewState extends State<FinishView> {
  int score = 0;

  @override
  void initState() {
    super.initState();
    calculateScore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (!didPop) {
            Navigator.pop(context);
            Navigator.pop(context);
          }
        },
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey.shade300),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Score: $score',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    'Time: ${(widget.time / 60).floor()}:${widget.time % 60}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 45, top: 25),
              height: MediaQuery.of(context).size.height * .43,
              width: MediaQuery.of(context).size.width * .9,
              child: buildGrid(),
            ),
            SudokuButton(
              label: 'Solution',
              onPressed: () {
                Sound.playSound();
                setState(
                  () {
                    for (int i = 0; i < widget.puzzle.length; i++) {
                      if (!(widget.puzzle[i].isCorrect)) {
                        widget.puzzle[i].color = Colors.blue.shade700;
                      }
                      widget.puzzle[i].number = widget.solution[i];
                    }
                  },
                );
              },
            ),
            const SizedBox(
              height: 30,
            ),
            SudokuButton(
              label: 'New Game',
              onPressed: () {
                Sound.playSound();
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  calculateScore() {
    for (int i = 0; i < widget.puzzle.length; i++) {
      if (widget.puzzle[i].number == widget.solution[i] &&
          widget.puzzle[i].status == Type.notFixed) {
        score += 20;
      }
    }
  }

  Widget buildNumberCard(int index) {
    return Container(
      decoration: BoxDecoration(
        color: widget.puzzle[index].color,
        border: Border.all(color: Colors.black54),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          (widget.puzzle[index].number > 0
              ? '${widget.puzzle[index].number}'
              : ''),
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget buildGrid() {
    return GridView.builder(
      itemCount: 81,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 9,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemBuilder: (context, index) => buildNumberCard(index),
    );
  }
}
