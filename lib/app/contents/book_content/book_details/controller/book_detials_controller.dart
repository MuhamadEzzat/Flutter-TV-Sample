import 'dart:async';

import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/audio_player_utils.dart';
import '../../../../core/utils/screen_orientation_util.dart';
import '../../../../data/models/book_model.dart';

class BookDetailsController extends GetxController with WidgetsBindingObserver {
  final Book book = Get.arguments["book"];

  final flipController = StreamController<int>.broadcast();
  RxInt nextFlipValue = 0.obs;
  late int bookPagesNo;
  Rx<AxisDirection> direction = Rx(AxisDirection.right);
  RxBool paused = false.obs;

  RxBool pausedPermanent = false.obs;
  RxBool flipDisabled = false.obs;
  RxBool inBackground = false.obs;

  RxBool nextFlag = false.obs;
  RxBool previousFlag = false.obs;

  RxInt totalMarkedPagesMarkerLength = 0.obs;
  RxInt markerIndex = 0.obs;
  Duration soundDuration = Duration.zero;
  Duration pausedAt = Duration.zero;

  StreamController<int>? highlightedIndex;

  AudioPlayer? _player;

  AudioPlayer? get player => _player;

  RxBool isMuteSoundButtonActivated = true.obs;
  RxBool reachToLastWord = false.obs;
  List<String> currentPageWords = [];

  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addObserver(this);
    onBookControllerInit();
    AudioPlayerUtil.enterVideoMode();
    if (book.bookMarker.isNotEmpty) {
      initBookVoice(book.bookVoice!, afterLoading: () {
        markWords();
        player?.play();
      });
    }
    if (book.bookMarker.isNotEmpty) {
      highlightedIndex!.sink.add(markerIndex.value);
    }
  }

  @override
  void dispose() {
    flipController.close();
    highlightedIndex?.close();
    _player?.stop();
    _player?.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    flipController.close();
    highlightedIndex?.close();
    _player?.stop();
    _player?.dispose();
    super.onClose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused) {
      player?.pause();
      inBackground.value = true;
      if (book.bookMarker.isNotEmpty) {
        pausedAt = book.bookMarker[markerIndex.value].start;
      }
    } else if (state == AppLifecycleState.resumed) {
      inBackground.value = false;
      if (Get.context!.mounted &&
          !pausedPermanent.value &&
          book.bookMarker.isNotEmpty &&
          markerIndex < book.bookMarker.length) {
        await player?.seek(pausedAt);
        markWords();
        player?.play();
      }
    }
  }

  void onBookControllerInit() {
    bookPagesNo = book.bookPages.length;
    highlightedIndex = StreamController<int>.broadcast();
    if (book.bookMarker.isNotEmpty) pausedAt = book.bookMarker.first.start;
    _player = AudioPlayer();
  }

  Future initBookVoice(String voiceUrl, {Function? afterLoading}) async {
    Duration? duration = await _player?.setUrl(voiceUrl);
    if (duration != null && duration != Duration.zero) {
      soundDuration = duration;
      afterLoading?.call();
    }
  }

  void flipNext({Function? beforeFlip, Function? onFlip}) =>
      nextFlipValue < bookPagesNo - 1
          ? {
              beforeFlip?.call(),
              Future.delayed(const Duration(milliseconds: 750), () {
                onFlip?.call();
              }),
              flipController.add(++nextFlipValue.value % bookPagesNo),
            }
          : null;

  void flipPrevious({Function? beforeFlip, Function? onFlip}) =>
      nextFlipValue > 0
          ? {
              beforeFlip?.call(),
              Future.delayed(const Duration(milliseconds: 750), () {
                onFlip?.call();
              }),
              flipController.add(--nextFlipValue.value % bookPagesNo),
            }
          : null;

  Future<void> markWords({bool isFlipEnabledTapped = false}) async {
    currentPageWords = book.bookPages[nextFlipValue.value].text.split(" ");

    reachToLastWord.value = currentPageWords.indexOf(currentPageWords.last) ==
        (markerIndex.value - totalMarkedPagesMarkerLength.value);

    // Check if Reach End of Book or in background
    if (markerIndex.value == book.bookMarker.length ||
        !Get.context!.mounted ||
        inBackground.value) return;
    // Check if reach last work in the page
    if (((markerIndex.value - totalMarkedPagesMarkerLength.value) ==
            book.bookPages[nextFlipValue.value].text.split(" ").length) ||
        isFlipEnabledTapped) {
      //if Page Auto Flip is on and in foreground
      if (!flipDisabled.value && Get.context!.mounted && !inBackground.value) {
        //Pause sound
        flipDisabled.value = false;
        await player?.pause();
        paused.value = true;

        flipNext(beforeFlip: () {
          debugPrint("beforeFlip noooooooooow");
          // disable mute button when the page flip to avoid some async problems between marker and sound
          isMuteSoundButtonActivated.value = false;

          Future.delayed(const Duration(milliseconds: 1500), () {
            isMuteSoundButtonActivated.value = true;
          });
          //change directionality if user do it manually
          if (direction.value == AxisDirection.left) {
            direction.value = AxisDirection.right;
          }
          // Add Page word length
          totalMarkedPagesMarkerLength.value +=
              book.bookPages[nextFlipValue.value].text.split(' ').length;
          //set marker index with accumulated page lnth
          markerIndex.value = totalMarkedPagesMarkerLength.value;
        }, onFlip: () {
          // disable mute button when the page flip to avoid some async problems between marker and sound
          isMuteSoundButtonActivated.value = false;
          Future.delayed(const Duration(milliseconds: 2500), () {
            isMuteSoundButtonActivated.value = true;
          });
        });
        await Future.delayed(const Duration(milliseconds: 1200));
        if (Get.context!.mounted && !inBackground.value) {
          debugPrint("Played before flip");
          player?.play();
        }
        paused.value = false;
      } else {
        flipDisabled.value = true;
        await player?.pause();
      }
    }
    if (Get.context!.mounted && !inBackground.value) {
      highlightedIndex!.sink.add(markerIndex.value);
    }
    // word duration = next word start - this word start
    var wordDuration = markerIndex.value == book.bookMarker.length - 1
        ? soundDuration - book.bookMarker[markerIndex.value].start
        : book.bookMarker[markerIndex.value + 1].start -
            book.bookMarker[markerIndex.value].start;

    debugPrint("wordDuration $wordDuration");

    Future.delayed(wordDuration - const Duration(milliseconds: 8)).then((_) {
      if (Get.context!.mounted &&
          !nextFlag.value &&
          !previousFlag.value &&
          !inBackground.value &&
          !paused.value &&
          !pausedPermanent.value) {
        markerIndex.value++;
        markWords();
      }
    });
  }

  void tapMuteSoundButton() {
    if (isMuteSoundButtonActivated.value) {
      if (book.bookMarker.isNotEmpty && !reachToLastWord.value) {
        if (pausedPermanent.value) {
          Future.delayed(const Duration(milliseconds: 550), () {
            player?.play();
            debugPrint("bookController.player?.play()");
          });
          pausedPermanent.value = false;
          markWords();
        } else {
          player?.pause();
          pausedPermanent.value = true;
        }
      }
      isMuteSoundButtonActivated.value = false;
      Future.delayed(const Duration(seconds: 1), () {
        isMuteSoundButtonActivated.value = true;
      });
    }
  }

  void previousPage() {
    return flipPrevious(
      beforeFlip: () {
        previousFlag.value = true;
        if (direction.value == AxisDirection.right) {
          direction.value = AxisDirection.left;
        }
        int previousLength =
            book.bookPages[nextFlipValue.value - 1].text.split(' ').length;
        totalMarkedPagesMarkerLength.value -= previousLength;
        markerIndex.value = totalMarkedPagesMarkerLength.value;
        player?.pause();
      },
      onFlip: () {
        Future.delayed(const Duration(seconds: 1), () async {
          if (book.bookMarker.isNotEmpty) {
            await player?.seek(book.bookMarker[markerIndex.value].start);
            previousFlag.value = false;
            markWords();
            if (!pausedPermanent.value && Get.context!.mounted) {
              player?.play();
            }
          }
        });
      },
    );
  }

  void nextPage() {
    return flipNext(
      beforeFlip: () {
        nextFlag.value = true;
        if (direction.value == AxisDirection.left) {
          direction.value = AxisDirection.right;
        }
        totalMarkedPagesMarkerLength.value +=
            book.bookPages[nextFlipValue.value].text.split(' ').length;
        markerIndex.value = totalMarkedPagesMarkerLength.value;
        player?.pause();
      },
      onFlip: () {
        Future.delayed(const Duration(seconds: 1), () async {
          if (book.bookMarker.isNotEmpty) {
            await player?.seek(book.bookMarker[markerIndex.value].start);
            nextFlag.value = false;
            markWords();
            if (!pausedPermanent.value && Get.context!.mounted) {
              player?.play();
            }
          }
        });
      },
    );
  }

  void goBack() {

    Get.back();
  }
}
