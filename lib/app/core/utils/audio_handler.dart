import 'dart:ui';

import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

MyAudioHandler? audioHandler;

Future<MyAudioHandler> initAudioService(List<MediaItem> items) async {
  return await AudioService.init(
    builder: () => MyAudioHandler(items),
    config: const AudioServiceConfig(
      // androidNotificationChannelId: 'com.jeelapp.android.audio',
      // androidNotificationChannelName: 'Jeel',
      // androidNotificationChannelDescription: 'Jeel Radio',
      // notificationColor: Color(0xFF2196f3),
      // androidNotificationIcon: 'mipmap/logo',
      // androidResumeOnClick: false,
      // androidNotificationOngoing: true,
      //androidStopForegroundOnPause: true,
    ),
  );
}

class MyAudioHandler extends BaseAudioHandler
    with
        QueueHandler, // mix in default queue callback implementations
        SeekHandler {
  // mix in default seek callback implementations

  final _player = AudioPlayer();
  int? get index => _player.currentIndex;
  bool manualSkip = false;
  //List<MediaItem> mediaItems = [];

  MyAudioHandler(List<MediaItem> items) {
    //mediaItems = items;
    _player.playbackEventStream.map(_transformEvent).pipe(playbackState);
    _player.currentIndexStream.listen((playerIndex) {
      if (index != null) {
        mediaItem.add(queue.value[index!]);
      }
    });
    updateQueue(items);
    _player.setAudioSource(ConcatenatingAudioSource(
        children: items.map((item) {
      return AudioSource.uri(Uri.parse(item.id));
    }).toList()));
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> stop() async {
    await _player.stop();
    await super.stop();
  }

  @override
  Future<void> skipToQueueItem(int index) async {
    if (this.index != null) {
      _player.seek(Duration.zero, index: index);
      mediaItem.add(queue.value[index]);
    }
    return super.skipToQueueItem(index);
  }

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    List<MediaItem> items = queue.value;
    items.addAll(mediaItems);
    final currentIndex = index;
    final currentPosition = _player.position;
    _player.setAudioSource(
        ConcatenatingAudioSource(
            children: items
                .map((item) => AudioSource.uri(Uri.parse(item.id)))
                .toList()),
        initialIndex: currentIndex,
        initialPosition: currentPosition);
    super.addQueueItems(mediaItems);
  }

  /*@override
  Future<void> skipToNext() async {
    skipToQueueItem((index??-1)+1);
    await super.skipToNext();
  }

  @override
  Future<void> skipToPrevious() async {
    skipToQueueItem((index??1)-1);
    await super.skipToPrevious();
  }*/

  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        MediaControl.skipToPrevious,
        //MediaControl.rewind,
        if (_player.playing) MediaControl.pause else MediaControl.play,
        //MediaControl.stop,
        //MediaControl.fastForward,
        MediaControl.skipToNext,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 2],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: _player.playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: event.currentIndex,
    );
  }
}
