import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../../../core/Constants/constants.dart';
import '../../../../core/utils/audio_handler.dart';
import '../../../../core/utils/audio_player_utils.dart';
import '../../../../core/utils/screen_orientation_util.dart';
import '../../../../core/values/localization/local_keys.dart';
import '../../../../data/models/channel_model.dart';
import '../../../../data/models/child_model.dart';
import '../../../../data/models/radio_model.dart';
import '../../../../routes/app_pages.dart';


enum PlayerState {
  /// initial state, stop has been called or an error occurred.
  stopped,

  /// Currently playing audio.
  playing,

  /// Pause has been called.
  paused,

  /// The audio successfully completed (reached the end).
  completed,
}

class ChildChannelNewController extends GetxController
    with WidgetsBindingObserver {
  final dynamic arguments = Get.arguments;
  DateTime? kidUsageStartTime;
  Rxn<Channel?> channel = Rxn<Channel?>();
  Rxn<RadioModel?> radio = Rxn<RadioModel?>();
  RxInt currentChannelIndex = 0.obs;
  int currentFixedIndex = 0;
  Rxn<List<Channel>?> channels = Rxn<List<Channel>?>();
  RxBool loading = false.obs;
  Rxn<Child> child = Rxn<Child>();
  DateTime start = DateTime.now();

  final ScrollController scrollController = ScrollController();
  RxBool isMuted = false.obs;
  String? currentLocale = Get.locale?.languageCode;

  bool isWeb = UniversalPlatform.isWeb;
  Rx<PlayerState> playerState = Rx(PlayerState.playing);
  AudioPlayer audioPlayer = AudioPlayer();

  Rx<double> audioTotalTime = 0.0.obs;
  Rx<double> playedTime = 0.0.obs;
  Rx<bool> firstTime = true.obs;
  Rx<bool> disposed = false.obs;
  String? audioUrl;

  ///Queue and audio service
  Rxn<List<MediaItem>?> queue = Rxn<List<MediaItem>?>();
  Rxn<MediaItem?> item = Rxn<MediaItem?>();


  @override
  void onInit() {
    super.onInit();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    ScreenOrientationUtil.landscape();
    getChildAndSections();
  }

  Future<bool> onWillPop() async {
    trackRadioChannel();
    await clearQueue();
    Get.back(result: currentFixedIndex);
    WidgetsBinding.instance.removeObserver(this);
    if (AppConstants.isAnonymous ||
        AppConstants.childId == null ||
        AppConstants.childId == -1) {
    }
    if (!AppConstants.isAnonymous &&
        AppConstants.childId != null &&
        AppConstants.childId != -1 &&
        kidUsageStartTime != null) {}
    return Future.value(true);
  }

  @override
  Future<void> onClose() async {
    trackRadioChannel();
    await clearQueue();
    Get.back(result: currentFixedIndex);
    WidgetsBinding.instance.removeObserver(this);
    if (AppConstants.isAnonymous ||
        AppConstants.childId == null ||
        AppConstants.childId == -1) {
    }
    if (!AppConstants.isAnonymous &&
        AppConstants.childId != null &&
        AppConstants.childId != -1 &&
        kidUsageStartTime != null) {}
    super.onClose();
  }

  Future<void> getChildAndSections() async {
    AudioPlayerUtil.enterVideoMode();
    radio.value = arguments[0][LocalKeys.kContentData] as RadioModel;
    currentChannelIndex.value = arguments[1][LocalKeys.kIndex] as int;
    audioHandler = arguments[3][LocalKeys.kAudioHandler] as MyAudioHandler;
    child.value = arguments[2][LocalKeys.kChild] ?? Child();
    currentFixedIndex = arguments[4]['SectionIndex'] as int;
    audioPayerStart();
  }

  launchPaymentURL() async {
    Get.offNamedUntil(Routes.PARENTAL_CONTROL, (route) => false,
        parameters: {"isFromPaidContentDialog": "true"});
  }

  audioPayerStart() async {
    audioHandler!.play();
  }

  changeCurrentIndex(String id) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      currentChannelIndex.value = radio.value!.channels!.indexWhere((ch) =>
          (AudioPlayerUtil.isMusicAllowed
              ? ch.trackWithMusic
              : ch.trackWithoutMusic) ==
          id);
    });
  }

  ///Change the screen depending on the current played time
  changePlayedTime(int time) {
    audioHandler!.pause();
    audioHandler!.seek(Duration(seconds: time));
    audioHandler!.play();
    playerState.value = PlayerState.playing;
  }

  seek(int time) {
    audioPlayer.seek(Duration(seconds: time));
  }

  ///Control Buttons Functions
  tenSecondsForward() {
    audioTotalTime.value - playedTime.value <= 10
        ? audioHandler!.seekForward(true)
        : audioHandler!
            .seek(Duration(seconds: (playedTime.value + 10).round()));
  }

  playPause() {
    if (playerState.value == PlayerState.playing) {
      audioHandler!.pause();
      playerState.value = PlayerState.paused;
    } else if (playerState.value == PlayerState.paused) {
      audioHandler!.play();
      playerState.value = PlayerState.playing;
    }
  }

  tenSecondsBackward() {
    if (playedTime.value == audioTotalTime.value) {
      audioHandler!.seek(
        Duration(
          seconds: playedTime.value <= 10 ? 0 : (playedTime.value - 10).round(),
        ),
      );
      audioHandler!.pause();
    } else {
      audioHandler!.seek(
        Duration(
          seconds: playedTime.value <= 10 ? 0 : (playedTime.value - 10).round(),
        ),
      );
    }
  }

  previousChannel() async {
    if (radio.value!.channels![currentChannelIndex.value - 1].isFree ||
        AppConstants.isPaidUser) {
      debugPrint('Plays: ${currentChannelIndex.value - 1}');
      currentChannelIndex.value -= 1;
      audioHandler!.skipToPrevious();
    } else {
      // audioHandler!.pause();
      // AudioPlayerUtil.play('paid_content_${AppConstants.childGender}.mp3');
      // showDialog(
      //     context: Get.context!,
      //     builder: (context) => const PaidContentDialog()).then((value) {
      //   if (value != null && value) {
      //     audioHandler!.stop();
      //   } else {
      //     audioHandler!.play();
      //   }
      // });
    }
  }

  trackRadioChannel() {
    print("track channel");
    if (AppConstants.childId != null &&
        AppConstants.childId != -1 &&
        !AppConstants.isAnonymous) {
      final duration = DateTime.now().difference(start).inSeconds.abs();


      start = DateTime.now();
    }
  }

  nextChannel() async {
    if (radio.value!.channels![currentChannelIndex.value + 1].isFree ||
        AppConstants.isPaidUser) {
      (currentChannelIndex.value >= radio.value!.channels!.length - 1)
          ? currentChannelIndex.value = 0
          : currentChannelIndex.value += 1;
      audioHandler!.play();
      audioHandler!.pause();
      trackRadioChannel();
      final index = audioHandler?.queue.value.indexWhere((mediaItem) =>
          mediaItem.id ==
          (AudioPlayerUtil.isMusicAllowed
              ? radio
                  .value!.channels![currentChannelIndex.value].trackWithMusic!
              : radio.value!.channels![currentChannelIndex.value]
                  .trackWithoutMusic!));
      if (index != null && index >= 0) {
        await audioHandler?.skipToQueueItem(index);
        audioHandler?.play();
      }
      // audioHandler!.skipToNext();
    } else {
      // AudioPlayerUtil.play('paid_content_${AppConstants.childGender}.mp3');
      // showDialog(
      //     context: Get.context!,
      //     builder: (context) => const PaidContentDialog()).then((value) {
      //   if (value != null && value) {
      //     audioHandler!.stop();
      //   } else {
      //     audioHandler!.play();
      //   }
      // });
    }
  }

  void dismissChannelsDialog() {
    Get.back();
  }

  void openChannelFromDrawer(int indx, bool isFromDrawer) async {
    if (radio.value!.channels![indx].isFree || AppConstants.isPaidUser) {
      if (isFromDrawer) {
        dismissChannelsDialog();
        audioHandler!.pause();
      }

      final index = audioHandler?.queue.value.indexWhere((mediaItem) =>
          mediaItem.id ==
          (AudioPlayerUtil.isMusicAllowed
              ? radio.value!.channels![indx].trackWithMusic!
              : radio.value!.channels![indx].trackWithoutMusic!));
      // if (index != null && index >= 0) {
      //   debugPrint("mediaItem Channel: ${ audioHandler?.queue.value[indx].title} , index ${index}, indx${indx}");
      //   await audioHandler?.skipToQueueItem(index);
      //   audioHandler?.play();
      // }
      if (index! <= audioHandler!.queue.value.length - 1) {
        currentChannelIndex.value =
            audioHandler!.queue.value.indexWhere((mediaItem) {
          debugPrint(
              "Media Item: ${mediaItem.id} || ${radio.value!.channels![index].trackWithoutMusic}");
          return mediaItem.id ==
              (AudioPlayerUtil.isMusicAllowed
                  ? radio.value!.channels![index].trackWithMusic!
                  : radio.value!.channels![index].trackWithoutMusic!);
        });
        debugPrint('current index: ${currentChannelIndex.value}');
        await audioHandler!.skipToQueueItem(currentChannelIndex.value);
        audioHandler!.play();
      } else {
        debugPrint("drawer index: $indx");
      }
      audioHandler!.play();
    } else {
      // audioHandler!.pause();
      // AudioPlayerUtil.play('paid_content_${AppConstants.childGender}.mp3');
      // showDialog(
      //     context: Get.context!,
      //     builder: (context) => const PaidContentDialog()).then((value) {
      //   if (value != null && value) {
      //     audioHandler!.stop();
      //   } else {
      //     audioHandler!.play();
      //   }
      // });
    }
  }

  Future<void> clearQueue() async {
    while (audioHandler!.queue.value.isNotEmpty) {
      debugPrint("audio item ${audioHandler!.queue.value.length}");
      audioHandler!.queue.value.removeLast();
    }
    debugPrint("audio assaitem ${audioHandler!.queue.value.length}");
    await audioHandler!.stop();
  }
}
