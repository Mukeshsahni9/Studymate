import 'package:audioplayers/audioplayers.dart';

class SoundUtils {
  static final AudioPlayer _audioPlayer = AudioPlayer();
  static bool _isInitialized = false;

  static Future<void> initialize() async {
    if (!_isInitialized) {
      await _audioPlayer.setSource(AssetSource('sounds/timer_complete.mp3'));
      _isInitialized = true;
    }
  }

  static Future<void> playTimerCompleteSound() async {
    await initialize();
    await _audioPlayer.resume();
  }

  static Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
} 