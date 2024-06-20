import 'package:audioplayers/audioplayers.dart';
import 'package:sudoku_game/views/settingsView.dart';

class Sound {
  static void playSound() {
    if (switch2) {
      AudioPlayer player = AudioPlayer();
      player.play(AssetSource('sound/Tick.mp3'));
    }
  }

  AudioPlayer musicPlayer = AudioPlayer();

  void playAndStopMusic() {
    if (switch1) {
      musicPlayer.setReleaseMode(ReleaseMode.loop);
      musicPlayer.play(AssetSource('sound/Sudoku Main Sound.mp3'));
    } else {
      musicPlayer.stop();
    }
  }
}
