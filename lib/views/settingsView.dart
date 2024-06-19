import 'package:flutter/material.dart';
import 'package:sudoku_game/appColors/appColors.dart';
import 'package:sudoku_game/sound/sound.dart';
import 'package:sudoku_game/widgets/containerWithDropDown.dart';
import 'package:sudoku_game/widgets/madeByWidget.dart';
import 'package:sudoku_game/widgets/sudokuSwitchContainer.dart';

class SettingsView extends StatefulWidget {
  Sound sound;

  SettingsView({required this.sound});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

bool switch1 = true;
bool switch2 = true;

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor.shade200,
      appBar: buildAppBar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: TextStyle(
                fontFamily: 'Chunq',
                color: AppColors.primaryColor,
                fontSize: 70,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Column(
              children: [
                SudokuSwitchContainer(
                    name: 'Music',
                    icon: Icons.music_note,
                    switchX: switch1,
                    onChanged: (value) {
                      Sound.playSound();
                      setState(() {
                        switch1 = value;
                      });
                      widget.sound.playAndStopMusic();
                    }),
                SudokuSwitchContainer(
                    name: 'Sound',
                    icon: Icons.keyboard_voice,
                    switchX: switch2,
                    onChanged: (value) {
                      Sound.playSound();
                      setState(() {
                        switch2 = value;
                      });
                    }),
                ContainerWithDropDown(),
                MadeByWidget()
              ],
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
          Sound.playSound();
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios_new),
      ),
    );
  }
}
