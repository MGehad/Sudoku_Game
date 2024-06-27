import 'package:flutter/material.dart';
import '../appColors/appColors.dart';
import '../models/numberModel.dart';
import '../sound/sound.dart';
import '../widgets/resultsContainer.dart';
import '../widgets/sudokuButton.dart';

class FinishView extends StatefulWidget {
  List<NumberModel> puzzle;
  final List<int> solution;
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
      appBar: buildAppBar(context),
      backgroundColor: AppColors.secondaryColor[200],
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
            ResultsContainer(score: score, time: widget.time),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: AppColors.lightColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondaryColor.shade400,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              height: MediaQuery.of(context).size.height * .43,
              width: MediaQuery.of(context).size.width * .9,
              child: buildGrid(),
            ),
            const SizedBox(height: 45.0),
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
            const SizedBox(height: 30),
            SudokuButton(
              label: 'New Game',
              onPressed: () {
                Sound.playSound();
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.secondaryColor.shade200,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios_new_rounded),
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
        border: Border.all(color: AppColors.secondaryColor.shade600),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          (widget.puzzle[index].number > 0
              ? '${widget.puzzle[index].number}'
              : ''),
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: AppColors.secondaryColor.shade900,
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
