import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class StreamCounter extends StatelessWidget {
  const StreamCounter({
    super.key,
    required StopWatchTimer stopWatchTimer,
  }) : _stopWatchTimer = stopWatchTimer;

  final StopWatchTimer _stopWatchTimer;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _stopWatchTimer.secondTime,
      builder: (context, snap) {
        final value = snap.data;
        return Container(
          padding: const EdgeInsets.only(bottom: 8.0),
          width: 120,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "${((value ?? 0) / 60).floor()} : ",
                style: const TextStyle(
                  fontSize: 35,
                  fontFamily: 'Digital',
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                ((value ?? 0) % 60).toString(),
                style: const TextStyle(
                  fontSize: 35,
                  fontFamily: 'Digital',
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
