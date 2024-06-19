import 'package:flutter/material.dart';
import 'package:sudoku_game/appColors/appColors.dart';

class ResultsContainer extends StatelessWidget {
  const ResultsContainer({
    super.key,
    required this.score,
    required this.time,
  });

  final int score;
  final int time;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: AppColors.secondaryColor.shade300),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Score: $score',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            'Time: ${(time / 60).floor()}:${time % 60}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
