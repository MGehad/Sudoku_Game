import 'package:flutter/material.dart';

class NumberCard extends StatefulWidget {
  int number;

  NumberCard({super.key, required this.number});

  @override
  State<NumberCard> createState() => _NumberCardState();
}

class _NumberCardState extends State<NumberCard> {
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return (widget.number > 0)
        ? Container(
            decoration: const BoxDecoration(color: Colors.black26),
            child: Center(
                child: Text(
              widget.number.toString(),
              style: const TextStyle(fontSize: 20),
            )),
          )
        : GestureDetector(
            onTap: () {
              setState(() {
              });
            },
            child: Container(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Center(
                  child: Text(
                (i != 0 ? '$i' : ''),
                style: const TextStyle(fontSize: 20),
              )),
            ),
          );
  }
}
