import 'package:flutter/material.dart';
import '../appColors/appColors.dart';

class SudokuSwitchContainer extends StatelessWidget {
  final String name;
  final IconData icon;
  final bool switchX;
  final Function(bool) onChanged;

  SudokuSwitchContainer(
      {required this.name,
      required this.icon,
      required this.switchX,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SwitchListTile(
        onChanged: onChanged,
        value: switchX,
        overlayColor: MaterialStatePropertyAll(Colors.tealAccent),
        activeColor: AppColors.lightColor,
        inactiveThumbColor: AppColors.primaryColor,
        title: Text(
          "$name",
          style: TextStyle(
              color: AppColors.lightColor,
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
        secondary: Icon(icon, color: AppColors.thirdColor, size: 25),
      ),
    );
  }
}
