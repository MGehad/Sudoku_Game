import 'package:flutter/material.dart';
import 'package:sudoku_game/appColors/appColors.dart';

class MadeByWidget extends StatelessWidget {
  const MadeByWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.gamepad_outlined,
                color: AppColors.thirdColor,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'Made by',
                style: TextStyle(
                    color: AppColors.lightColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Text(
            'ENG Mohamed Gehad',
            style: TextStyle(
                color: AppColors.thirdColor.shade100,
                fontSize: 17,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
