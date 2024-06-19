import 'package:flutter/material.dart';
import 'package:sudoku_game/appColors/appColors.dart';

class NumberModel {
  int number;
  Type status;
  Color color;
  bool isCorrect;

  NumberModel(
      {required this.number,
      required this.status,
      required this.color,
      required this.isCorrect});

  static List<NumberModel> listToNumberModelList(List<int> list) {
    List<NumberModel> models = [];
    for (int element in list) {
      models.add(
        NumberModel(
            number: element,
            status: (element == -1) ? Type.notFixed : Type.fixed,
            color: (element == -1) ? AppColors.lightColor : AppColors.primaryColor.shade50,
            isCorrect: false),
      );
    }
    return models;
  }

  static indexOfEmptyCard(List<NumberModel> puzzle) {
    for (int i = 0; i < puzzle.length; i++) {
      if (puzzle[i].number == -1) {
        return i;
      }
    }
    return -1;
  }
}

enum Type { fixed, notFixed }
