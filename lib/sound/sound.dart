import 'package:audioplayers/audioplayers.dart';
import '../views/settingsView.dart';

class Sound {
  static void playSound() {
    if (soundSwitch) {
      AudioPlayer player = AudioPlayer();
      player.play(AssetSource('sound/Tick.mp3'));
    }
  }

  AudioPlayer musicPlayer = AudioPlayer();

  void playAndStopMusic() {
    if (musicSwitch) {
      musicPlayer.setReleaseMode(ReleaseMode.loop);
      musicPlayer.play(AssetSource('sound/Sudoku Main Sound.mp3'));
    } else {
      musicPlayer.stop();
    }
  }
}
