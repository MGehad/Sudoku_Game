import 'package:flutter/material.dart';
import 'package:sudoku_game/appColors/appColors.dart';

class ContainerWithDropDown extends StatelessWidget {
  const ContainerWithDropDown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
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
                Icons.language,
                color: AppColors.thirdColor,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'Language',
                style: TextStyle(
                    color: AppColors.lightColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          DropdownButton(
            icon: Icon(
              Icons.arrow_drop_down,
              color: AppColors.thirdColor,
            ),
            style: TextStyle(color: Colors.white),
            borderRadius: BorderRadius.circular(5),
            dropdownColor: AppColors.primaryColor.shade400,
            items: [
              DropdownMenuItem(
                child: Text(
                  'English',
                  style: TextStyle(color: AppColors.lightColor),
                ),
              ),
            ],
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
