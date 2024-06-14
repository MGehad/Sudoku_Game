import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:sudoku_dart/sudoku_dart.dart';
import 'package:sudoku_game/models/numberModel.dart';

class GameView extends StatefulWidget {
  final String gameLevel;

  const GameView({super.key, required this.gameLevel});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  late List<NumberModel> puzzle;
  late List<int> solution;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer();

  @override
  void initState() {
    super.initState();
    Level level = switchLevel(widget.gameLevel);
    Sudoku sudoku = Sudoku.generate(level);
    solution = sudoku.solution;
    puzzle = NumberModel.listToNumberModelList(sudoku.puzzle);
    _stopWatchTimer.onStartTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.gameLevel.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 70),
                StreamBuilder<int>(
                  stream: _stopWatchTimer.secondTime,
                  builder: (context, snap) {
                    final value = snap.data;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "${((value ?? 0) / 60).floor()} : ",
                          style: const TextStyle(
                            fontSize: 35,
                            fontFamily: 'Digital',
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          ((value ?? 0) % 60).toString(),
                          style: const TextStyle(
                            fontSize: 35,
                            fontFamily: 'Digital',
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            height: MediaQuery.of(context).size.height * 0.51,
            child: buildGrid(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .65,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        buildButton(txt: "7"),
                        buildButton(txt: "8"),
                        buildButton(txt: "9"),
                      ],
                    ),
                    Row(
                      children: [
                        buildButton(txt: "4"),
                        buildButton(txt: "5"),
                        buildButton(txt: "6"),
                      ],
                    ),
                    Row(
                      children: [
                        buildButton(txt: "1"),
                        buildButton(txt: "2"),
                        buildButton(txt: "3"),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  AnimatedButton(
                    width: 80,
                    height: 100,
                    text: 'Clear',
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.blueAccent,
                    pressEvent: () => AwesomeDialog(
                      context: context,
                      dialogType: DialogType.question,
                      animType: AnimType.scale,
                      desc: 'Are you sure..?',
                      dismissOnTouchOutside: true,
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {
                        setState(
                          () {
                            for (int i = 0; i < puzzle.length; i++) {
                              puzzle[i].isSelected = false;
                              if (puzzle[i].status == Type.notFixed) {
                                puzzle[i].number = -1;
                              }
                            }
                          },
                        );
                      },
                    ).show(),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  AnimatedButton(
                    width: 80,
                    height: 100,
                    text: 'Done',
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.blueAccent,
                    pressEvent: () => AwesomeDialog(
                      context: context,
                      dialogType: DialogType.question,
                      animType: AnimType.scale,
                      desc: 'Are you sure..?',
                      dismissOnTouchOutside: true,
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {
                        setState(
                          () {
                            _stopWatchTimer.onStopTimer();
                            for (int i = 0; i < puzzle.length; i++) {
                              if (puzzle[i].number == solution[i]) {
                                puzzle[i].isCorrect = true;
                              }
                            }
                          },
                        );
                      },
                    ).show(),
                  ),
                ],
              ),
            ],
          ),
        ],
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

  Widget buildNumberCard(int index) {
    return GestureDetector(
      onTap: () {
        setState(
          () {
            for (var element in puzzle) {
              element.isSelected = false;
            }
            puzzle[index].isSelected = true;
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: (puzzle[index].isCorrect)
              ? Colors.green
              : (puzzle[index].isSelected)
                  ? Colors.black26
                  : Colors.white,
          border: Border.all(color: Colors.black54),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            (puzzle[index].number > 0 ? '${puzzle[index].number}' : ''),
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButton({required String txt}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              for (var list in puzzle) {
                if (list.isSelected && list.status == Type.notFixed) {
                  list.number = int.parse(txt);
                }
              }
            });
          },
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 20),
            ),
            backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          child: Text(
            txt,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
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
