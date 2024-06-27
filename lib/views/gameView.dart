import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:sudoku_dart/sudoku_dart.dart';
import '../appColors/appColors.dart';
import '../models/numberModel.dart';
import '../sound/sound.dart';
import '../widgets/streamCounter.dart';
import '../widgets/sudokuAnimatedButton.dart';
import '../widgets/sudokuButton.dart';
import 'finishView.dart';


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
      appBar: buildAppBar(context),
      backgroundColor: AppColors.secondaryColor[200],
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (!didPop) {
            sudokuAwesomeDialog(btnOkOnPress: () {
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
                  StreamCounter(stopWatchTimer: _stopWatchTimer),
                  buildHintStack(),
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
                Sound.playSound();
                isCompleted = true;
                for (int i = 0; i < puzzle.length; i++) {
                  if (puzzle[i].number == solution[i]) {
                    puzzle[i].isCorrect = true;
                  }
                  if (puzzle[i].number == -1) {
                    isCompleted = false;
                  }
                }
                if (isCompleted) {
                  _stopWatchTimer.onStopTimer();
                  for (var element in puzzle) {
                    if (element.status == Type.fixed) {
                      element.color = AppColors.secondaryColor.shade300;
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

  Stack buildHintStack() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              Sound.playSound();
              if (hints > 0) {
                int index = NumberModel.indexOfEmptyCard(puzzle);
                if (index != -1) {
                  puzzle[index] = NumberModel(
                    number: solution[index],
                    status: Type.fixed,
                    color: AppColors.primaryColor.shade50,
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
                MaterialStatePropertyAll(AppColors.secondaryColor.shade300),
          ),
        ),
        Positioned(
          right: 2,
          top: -12,
          child: Container(
            child: Text(
              '$hints',
              style: TextStyle(color: AppColors.lightColor, fontSize: 15),
            ),
            padding: EdgeInsets.all(5),
            decoration:
                BoxDecoration(color: Colors.red, shape: BoxShape.circle),
          ),
        ),
      ],
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.secondaryColor.shade200,
      centerTitle: true,
      title: Text(
        widget.gameLevel.toUpperCase(),
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: AppColors.secondaryColor.shade900,
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Sound.playSound();
          sudokuAwesomeDialog(btnOkOnPress: () {
            Sound.playSound();
            Navigator.pop(context);
          });
        },
        icon: Icon(Icons.arrow_back_ios_new_rounded),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Sound.playSound();
            _stopWatchTimer.onStopTimer();
            _showPauseMenu();
          },
          icon: Icon(Icons.pause),
        )
      ],
    );
  }

  void _showPauseMenu() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.secondaryColor.shade50,
          title: Center(
            child: Text(
              "Menu",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: AppColors.primaryColor),
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
                      Sound.playSound();
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
                      Sound.playSound();
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
                    label: 'Exit',
                    onPressed: () {
                      Sound.playSound();
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

  sudokuAwesomeDialog({required VoidCallback btnOkOnPress}) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.scale,
      desc: 'Are you want to exit..?',
      dismissOnTouchOutside: true,
      btnCancelOnPress: () {
        Sound.playSound();
      },
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
        Sound.playSound();
        setState(
          () {
            if (puzzle[index].status == Type.notFixed) {
              for (var element in puzzle) {
                element.color = (element.status == Type.fixed)
                    ? AppColors.primaryColor.shade50
                    : AppColors.lightColor;
                ;
              }
              puzzle[index].color = AppColors.primaryColor.shade400;
              Set<int> set = getRowAndColumn(index);
              for (int element in set) {
                puzzle[element].color = (puzzle[element].status == Type.fixed)
                    ? AppColors.primaryColor.shade200
                    : AppColors.primaryColor.shade100;
              }
            }
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: puzzle[index].color,
          border: Border.all(color: AppColors.secondaryColor.shade600),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            (puzzle[index].number > 0 ? '${puzzle[index].number}' : ''),
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: AppColors.secondaryColor.shade900,
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
          Sound.playSound();
          setState(() {
            for (var list in puzzle) {
              if (list.color == AppColors.primaryColor.shade400) {
                list.number = int.parse(txt);
              }
            }
          });
        },
        style: ButtonStyle(
          fixedSize: MaterialStatePropertyAll(Size(70, 40)),
          backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
          ),
        ),
        child: Text(
          txt,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: AppColors.lightColor,
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
          Sound.playSound();
          setState(() {
            for (var list in puzzle) {
              if (list.color == AppColors.primaryColor.shade400) {
                list.number = -1;
              }
            }
          });
        },
        style: ButtonStyle(
          fixedSize: MaterialStatePropertyAll(Size(70, 40)),
          backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
          ),
        ),
        child: Icon(
          Icons.highlight_remove_rounded,
          color: AppColors.lightColor,
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
