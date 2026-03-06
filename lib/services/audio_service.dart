import 'package:audioplayers/audioplayers.dart';

class AudioService {
  AudioService._();

  static bool enabled = true;

  static final AudioPlayer _oneShotPlayer = AudioPlayer();
  static final AudioPlayer _ambientPlayer = AudioPlayer();

  static const String _pathTap = 'assets/audio/tap.mp3';
  static const String _pathLike = 'assets/audio/like.mp3';
  static const String _pathSave = 'assets/audio/save.mp3';
  static const String _pathFlip = 'assets/audio/flip.mp3';
  static const String _pathLevelUp = 'assets/audio/level_up.mp3';
  static const String _pathAmbient = 'assets/audio/ambient.mp3';

  static const double _ambientVolume = 0.25;

  static Future<void> _play(String path, {double volume = 1.0}) async {
    if (!enabled) return;
    try {
      await _oneShotPlayer.setVolume(volume);
      await _oneShotPlayer.play(AssetSource(path.replaceFirst('assets/', '')));
    } catch (_) {}
  }

  static void playTap() => _play(_pathTap);
  static void playLike() => _play(_pathLike);
  static void playSave() => _play(_pathSave);
  static void playFlip() => _play(_pathFlip);
  static void playLevelUp() => _play(_pathLevelUp);

  static Future<void> startAmbient() async {
    if (!enabled) return;
    try {
      await _ambientPlayer.setReleaseMode(ReleaseMode.loop);
      await _ambientPlayer.setVolume(_ambientVolume);
      await _ambientPlayer.play(AssetSource(_pathAmbient.replaceFirst('assets/', '')));
    } catch (_) {}
  }

  static Future<void> stopAmbient() async {
    try {
      await _ambientPlayer.stop();
    } catch (_) {}
  }
}
