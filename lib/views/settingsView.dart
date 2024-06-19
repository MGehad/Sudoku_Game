import 'package:flutter/material.dart';
import 'package:sudoku_game/sound/sound.dart';
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
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        leading: IconButton(
          onPressed: () {
            Sound.playSound();
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: TextStyle(
                fontFamily: 'Chunq',
                color: Colors.indigo,
                fontSize: 70,
              ),
            ),
            SizedBox(
              height: 30,
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.language,
                            color: Colors.tealAccent,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Language',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      DropdownButton(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.tealAccent,
                        ),
                        style: TextStyle(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                        dropdownColor: Colors.indigo.shade400,
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              'English',
                            ),
                          ),
                        ],
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.gamepad_outlined,
                            color: Colors.tealAccent,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Made by',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Text(
                        'ENG Mohamed Gehad',
                        style: TextStyle(
                            color: Colors.tealAccent.shade100,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
