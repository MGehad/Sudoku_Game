import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:sudoku_dart/sudoku_dart.dart';
import 'package:sudoku_game/models/numberModel.dart';
import 'package:sudoku_game/views/finishView.dart';
import 'package:sudoku_game/widgets/sudokuAnimatedButton.dart';
import 'package:sudoku_game/widgets/sudokuButton.dart';

class GameView extends StatefulWidget {
  final String gameLevel;

  const GameView({super.key, required this.gameLevel});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  late List<NumberModel> puzzle;
  late List<int> solution;
  late List<int> original;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer();

  bool isCompleted = true;
  int hints = 3;

  @override
  void initState() {
    super.initState();
    Level level = switchLevel(widget.gameLevel);
    Sudoku sudoku = Sudoku.generate(level);
    original = sudoku.puzzle;
    solution = sudoku.solution;
    puzzle = NumberModel.listToNumberModelList(original);
    _stopWatchTimer.onStartTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade200,
        centerTitle: true,
        title: Text(
          widget.gameLevel.toUpperCase(),
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            sudokuAwesomeDialog(() {
              Navigator.pop(context);
            });
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _stopWatchTimer.onStopTimer();
              _showPauseMenu();
            },
            icon: Icon(Icons.pause),
          )
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (!didPop) {
            sudokuAwesomeDialog(() {
              Navigator.pop(context);
            });
          }
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /*SudokuAnimatedButton(
                    text: 'Clear',
                    btnOkOnPress: () {
                      setState(() {
                        for (int i = 0; i < puzzle.length; i++) {
                          puzzle[i].color = (puzzle[i].status == Type.fixed)
                              ? Colors.indigo.shade50
                              : Colors.white;
                          if (puzzle[i].status == Type.notFixed) {
                            puzzle[i].number = -1;
                          }
                        }
                      });
                    },
                  ),*/
                  StreamBuilder<int>(
                    stream: _stopWatchTimer.secondTime,
                    builder: (context, snap) {
                      final value = snap.data;
                      return Container(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
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
                        ),
                      );
                    },
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (hints > 0) {
                              int index = NumberModel.indexOfEmptyCard(puzzle);
                              if (index != -1) {
                                puzzle[index] = NumberModel(
                                  number: solution[index],
                                  status: Type.fixed,
                                  color: Colors.indigo.shade50,
                                  isCorrect: false,
                                );
                              }
                              hints--;
                            }
                          });
                        },
                        icon: Icon(
                          Icons.lightbulb,
                          color: Colors.cyan,
                          size: 30,
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.grey.shade300),
                        ),
                      ),
                      Positioned(
                        right: 2,
                        top: -12,
                        child: Container(
                          child: Text(
                            '$hints',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.red, shape: BoxShape.circle),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              height: MediaQuery.of(context).size.height * 0.51,
              child: buildGrid(),
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildNumberButton(txt: "1"),
                    buildNumberButton(txt: "3"),
                    buildNumberButton(txt: "5"),
                    buildNumberButton(txt: "7"),
                    buildNumberButton(txt: "9"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildNumberButton(txt: "2"),
                    buildNumberButton(txt: "4"),
                    buildNumberButton(txt: "6"),
                    buildNumberButton(txt: "8"),
                    buildRemoveButton(),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SudokuAnimatedButton(
              text: 'Done',
              btnOkOnPress: () {
                isCompleted = true;
                for (int i = 0; i < puzzle.length; i++) {
                  if (puzzle[i].number == solution[i]) {
                    puzzle[i].isCorrect = true;
                  }
                  if (puzzle[i].number == -1) {
                    isCompleted = false;
                  }
                }
                if (!isCompleted) {
                  _stopWatchTimer.onStopTimer();
                  for (var element in puzzle) {
                    if (element.status == Type.fixed) {
                      element.color = Colors.grey.shade300;
                    } else if (element.isCorrect) {
                      element.color = Colors.green;
                    } else {
                      element.color = Colors.red;
                    }
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FinishView(
                        puzzle: puzzle,
                        time: _stopWatchTimer.secondTime.value,
                        solution: solution,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please complete the game..'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showPauseMenu() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade50,
          title: Center(
            child: Text(
              "Menu",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.indigo),
            ),
          ),
          elevation: 0,
          actions: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SudokuButton(
                    label: 'Resume',
                    onPressed: () {
                      _stopWatchTimer.onStartTimer();
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SudokuButton(
                    label: 'Restart',
                    onPressed: () {
                      _stopWatchTimer.onResetTimer();
                      setState(() {
                        puzzle = NumberModel.listToNumberModelList(original);
                        hints = 3;
                      });
                      Navigator.pop(context);
                      _stopWatchTimer.onStartTimer();
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SudokuButton(
                    label: 'New Game',
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  sudokuAwesomeDialog(VoidCallback btnOkOnPress) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.scale,
      desc: 'Are you want to exit..?',
      dismissOnTouchOutside: true,
      btnCancelOnPress: () {},
      btnOkOnPress: btnOkOnPress,
    ).show();
  }

  Widget buildGrid() {
    return GridView.builder(
      itemCount: 81,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 9,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemBuilder: (context, index) => buildSudokuNumber(index),
    );
  }

  Widget buildSudokuNumber(int index) {
    return GestureDetector(
      onTap: () {
        setState(
          () {
            if (puzzle[index].status == Type.notFixed) {
              for (var element in puzzle) {
                element.color = (element.status == Type.fixed)
                    ? Colors.indigo.shade50
                    : Colors.white;
                ;
              }
              puzzle[index].color = Colors.indigo.shade400;
              Set<int> set = getRowAndColumn(index);
              for (int element in set) {
                puzzle[element].color = (puzzle[element].status == Type.fixed)
                    ? Colors.indigo.shade200
                    : Colors.indigo.shade100;
              }
            }
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: puzzle[index].color,
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

  Set<int> getRowAndColumn(int index) {
    Set<int> set = {};

    for (int i = 0; i < 81; i++) {
      if (((index - i) % 9).abs() == 0) {
        set.add(i);
      }
      if (i < 9) {
        int start = (index / 9).floor() * 9;
        set.add(start + i);
      }
    }

    set.remove(index);
    return set;
  }

  Widget buildNumberButton({required String txt}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            for (var list in puzzle) {
              if (list.color == Colors.indigo.shade400) {
                list.number = int.parse(txt);
              }
            }
          });
        },
        style: ButtonStyle(
          fixedSize: MaterialStatePropertyAll(Size(70, 40)),
          backgroundColor: MaterialStateProperty.all(Colors.indigo),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
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
    );
  }

  Widget buildRemoveButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            for (var list in puzzle) {
              if (list.color == Colors.indigo.shade400) {
                list.number = -1;
              }
            }
          });
        },
        style: ButtonStyle(
          fixedSize: MaterialStatePropertyAll(Size(70, 40)),
          backgroundColor: MaterialStateProperty.all(Colors.indigo),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
          ),
        ),
        child: Icon(
          Icons.highlight_remove_rounded,
          color: Colors.white,
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
