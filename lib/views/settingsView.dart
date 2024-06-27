import 'package:flutter/material.dart';
import '../appColors/appColors.dart';
import '../sound/sound.dart';
import '../widgets/containerWithDropDown.dart';
import '../widgets/madeByWidget.dart';
import '../widgets/sudokuSwitchContainer.dart';

class SettingsView extends StatefulWidget {
  final Sound music;

  SettingsView({required this.music});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

bool musicSwitch = true;
bool soundSwitch = true;

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
                    switchX: musicSwitch,
                    onChanged: (value) {
                      Sound.playSound();
                      setState(() {
                        musicSwitch = value;
                      });
                      widget.music.playAndStopMusic();
                    }),
                SudokuSwitchContainer(
                    name: 'Sound',
                    icon: Icons.keyboard_voice,
                    switchX: soundSwitch,
                    onChanged: (value) {
                      Sound.playSound();
                      setState(() {
                        soundSwitch = value;
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
