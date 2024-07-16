import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart' as just_audio;
import 'package:multimedia_tv_sample/app/core/utils/shared_prefs_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';

class AudioPlayerUtil {
  //For asset audios using audiocache is a must instead of audioplayer directly
  // static AudioCache backgroundMusicPlayer = AudioCache(
  //     prefix: (UniversalPlatform.isWeb && kDebugMode) ? "" : "assets/");

  static AudioCache audioCachePlayer =
      AudioCache(prefix: UniversalPlatform.isWeb ? "" : "assets/");

  // static AudioCache player2 = AudioCache(
  //     prefix: (UniversalPlatform.isWeb && kDebugMode) ? "" : "assets/");

  static just_audio.AudioPlayer player2 = just_audio.AudioPlayer();

  static just_audio.AudioPlayer backgroundMusicPlayer =
      just_audio.AudioPlayer();

  static bool _isInVideo = false;
  static bool _isMusicEnabled = true;
  static bool _muteBackgroundMusic = false;
  static bool _isVolume0 = false;
  static bool isBackgroundMusicFirstTime = false;

  static playBackgroundMusic({required bool isAcapella}) async {
    debugPrint('play audio');
    String bgAudioFile =
        isAcapella ? 'backgroundacapella.mp3' : 'backgroundmusic.mp3';
    debugPrint("backgroundMusicPlayer.play();");
    backgroundMusicPlayer.setAsset("assets/audios/$bgAudioFile");
    backgroundMusicPlayer.play();
    //backgroundMusicPlayer.play(AssetSource("audios/$bgAudioFile"), volume: 0.9, mode: PlayerMode.mediaPlayer);
    if (UniversalPlatform.isWeb || UniversalPlatform.isIOS) {
      resumeBackgroundMusic();
    }

    await backgroundMusicPlayer.setLoopMode(just_audio.LoopMode.all);
    //backgroundMusicPlayer.setReleaseMode(ReleaseMode.loop);
    _isVolume0 = false;
  }

  static init() {
    SharedPreferences? prefs = SharedPrefsUtil.instance;
    _isMusicEnabled = (prefs?.get('PLAY_MUSIC') as bool?) ?? false;
    debugPrint('Is music allowed in prefs? $_isMusicEnabled');
  }

  static void muteOrUnmuteBackgroundMusic() {
    _muteBackgroundMusic = !_muteBackgroundMusic;
    if (_muteBackgroundMusic) {
      stopBackgroundMusic();
    } else {
      checkIfShouldPlayBackgroundMusic();
    }
  }

  static bool isMuted() {
    return _muteBackgroundMusic;
  }

  static bool get isMusicAllowed => _isMusicEnabled;

  static Future allowMusic() async {
    _isMusicEnabled = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('PLAY_MUSIC', true);
  }

  static Future disallowMusic() async {
    _isMusicEnabled = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('PLAY_MUSIC', false);
  }

  static checkIfShouldPlayBackgroundMusic() async {
    if (_isInVideo || _muteBackgroundMusic) {
      debugPrint("stopBackgroundMusic");
      stopBackgroundMusic();
    } else {
      debugPrint("playBackgroundMusic");
      playBGMusic();
    }
  }

  static playBGMusic() {
    if (_isMusicEnabled) {
      debugPrint("MusicEnabled");
      playBackgroundMusic(isAcapella: false);
    } else {
      debugPrint("MusicNotEnabled");
      playBackgroundMusic(isAcapella: true);
    }
  }

  static stopBackgroundMusic() async {
    if (UniversalPlatform.isIOS || UniversalPlatform.isWeb) {
      muteMusic();
    } else {
      debugPrint('stop audio');
      await backgroundMusicPlayer.stop();
    }
  }

  static muteMusic() async {
    debugPrint('Muted');
    await backgroundMusicPlayer.setVolume(0);
    _isVolume0 = true;
  }

  static resumeBackgroundMusic() async {
    if (_isVolume0) {
      await backgroundMusicPlayer.setVolume(0.3);
      _isVolume0 = false;
    }
    backgroundMusicPlayer.play();
    //backgroundMusicPlayer.resume();
  }

  static pauseBackgroundMusic() {
    if (UniversalPlatform.isIOS || UniversalPlatform.isWeb) {
      muteMusic();
    } else {
      backgroundMusicPlayer.pause();
    }
  }

  static void enterVideoMode() {
    debugPrint('enter video audio');
    _isInVideo = true;
    stopBackgroundMusic();
  }

  static void exitVideoMode() {
    debugPrint('exit video audio');
    _isInVideo = false;
    checkIfShouldPlayBackgroundMusic();
  }

  static Future<Uri> loadAsset(String fileName) async {
    //Use AudioCache to load assets into files
    final uri = await audioCachePlayer.load(fileName);
    return uri;
  }

  static play(String fileName, {VoidCallback? onFinish}) async {
    StreamSubscription? listener;
    listener = player2.playerStateStream.listen((state) {
      if (state.processingState == just_audio.ProcessingState.completed) {
        if (onFinish != null) onFinish();
        listener?.cancel();
      }
    });
    await player2.setAsset("assets/audios/$fileName");
    await player2.play();

    // listener = player2.onPlayerComplete.listen((v) {
    //   if (onFinish != null) onFinish();
    //   listener?.cancel();
    // });

    // player2.play(AssetSource("audios/$fileName"),
    //     volume: 0.9, mode: PlayerMode.mediaPlayer);
    debugPrint("player2.play $fileName");
  }

  static stop() {
    player2.stop();
    // if (UniversalPlatform.isIOS || UniversalPlatform.isWeb) {
    //   player2.setVolume(0.0);
    // } else {
    //   player2.stop();
    // }
  }

  static playUrl(String audioUrl, {Function()? onFinish}) async {
    debugPrint("playCacheUrl player2.play");
    await player2.setUrl(audioUrl);
    await player2.play();
    StreamSubscription? listener;
    listener = player2.playerStateStream.listen((state) {
      if (state.processingState == just_audio.ProcessingState.completed) {
        if (onFinish != null) onFinish();
        listener?.cancel();
      }
    });

    // player2.play(UrlSource(audioUrl), volume: 0.9);

    // listener = player2.onPlayerComplete.listen((v) {
    //   if (onFinish != null) onFinish();
    //   listener?.cancel();
    // });
  }

  static Future<File?> _getCachedFile(String url) async {
    /*FileInfo? fileInfo = await DefaultCacheManager().getFileFromCache(url);
    if (fileInfo == null) {
      DefaultCacheManager().downloadFile(url);
      return null;
    } else {
      return fileInfo.file;
    }*/
    return null;
  }
}
