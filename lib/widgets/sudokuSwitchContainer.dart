import 'package:flutter/material.dart';

class SudokuSwitchContainer extends StatelessWidget {
  String name;
  IconData icon;
  bool switchX;
  Function(bool) onChanged;

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
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SwitchListTile(
        onChanged: onChanged,
        value: switchX,
        overlayColor: MaterialStatePropertyAll(Colors.tealAccent),
        activeColor: Colors.white,
        inactiveThumbColor: Colors.indigo,
        title: Text(
          "$name",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        secondary: Icon(icon, color: Colors.tealAccent, size: 25),
      ),
    );
  }
}
