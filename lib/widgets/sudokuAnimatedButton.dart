import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import '../sound/sound.dart';

class SudokuAnimatedButton extends StatelessWidget {
  final String text;
  final VoidCallback btnOkOnPress;

  SudokuAnimatedButton(
      {super.key, required this.text, required this.btnOkOnPress});

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      width: 100,
      text: text,
      buttonTextStyle: const TextStyle(
        fontSize: 30,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      color: Colors.indigo.shade700,
      pressEvent: () => AwesomeDialog(
        context: context,
        dialogType: DialogType.question,
        animType: AnimType.scale,
        desc: 'Are you sure..?',
        dismissOnTouchOutside: true,
        btnCancelOnPress: () {
          Sound.playSound();
        },
        btnOkOnPress: btnOkOnPress,
      ).show(),
    );
  }
}
