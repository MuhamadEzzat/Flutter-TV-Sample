import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:vdocipher_flutter/vdocipher_flutter.dart';

import '../../../core/Constants/constants.dart';
import '../../../core/utils/audio_player_utils.dart';
import '../../../core/utils/screen_orientation_util.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/localization/local_keys.dart';
import '../../../data/enums/content_type.dart';
import '../../../data/models/activities_model.dart';
import '../../../data/models/child_model.dart';
import '../../../data/models/episode_model.dart';
import '../../../data/models/series_model.dart';
import '../../../data/providers/activities_provider.dart';
import '../../../data/providers/video_cipher_provider.dart';
import '../../../routes/app_pages.dart';

class VideoCipherController extends GetxController with WidgetsBindingObserver {
  final dynamic arguments = Get.arguments;
  DateTime? kidUsageStartTime;
  RxBool loading = false.obs;
  RxBool videoLoading = false.obs;
  Rxn<Episode?> episode = Rxn<Episode?>();
  Rxn<Child> child = Rxn<Child>();
  Rxn<ContentType> contentType = Rxn<ContentType>();
  final ScrollController scrollController = ScrollController();
  RxInt currentIndex = 0.obs;
  RxBool isMuted = false.obs;
  RxBool isBackEnabled = true.obs;
  String? currentLocale = Get.locale?.languageCode;

  bool isWeb = UniversalPlatform.isWeb;
  RxBool loadingVideo = false.obs;
  RxString? signedVideoUrl = ''.obs;
  Rx<VdoPlayerController?> controller_vdo = Rx(null);
  Rx<VdoPlayerValue?> vdoPlayerValue = Rx(null);
  RxBool isFullScreen = RxBool(false);

  Rx<EmbedInfo?> sample_1 = Rx(null);
  Activity? activity;
  Serial? serial;
  RxBool isEnded = false.obs;
  bool isFromBanner = false;

  @override
  void onInit() {
    super.onInit();
    ScreenOrientationUtil.landscapeFromPortrait();

  }

  @override
  Future<void> onReady() async {
    // TODO: implement onReady
    super.onReady();
    await getvideoUrl();
  }

  Future<void> getvideoUrl() async {
      await _initializeVideoPlayer(
          "91aa856f2f384c4caad5e7a49e82edfe");
  }

  Future<bool> onWillPop() async {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
    if (!AppConstants.isAnonymous &&
        (AppConstants.childId == null || AppConstants.childId == -1)) {}
    Get.back(result: false);
    return Future.value(false);
  }

  @override
  void onClose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    // controller_vdo.value?.dispose();
    controller_vdo.value = null;
    vdoPlayerValue.value = null;
    sample_1.value = null;
    // WidgetsBinding.instance.removeObserver(this);
    if (AppConstants.isAnonymous ||
        AppConstants.childId == null ||
        AppConstants.childId == -1) {
      if (!(Get.currentRoute == "/child-serial-details-new")) {
      }
    }
    if (!AppConstants.isAnonymous &&
        AppConstants.childId != null &&
        AppConstants.childId != -1 &&
        kidUsageStartTime != null) {}
    if (!(Get.currentRoute == "/child-serial-details-new")) {
    }
    // Get.back(result: true);
    // ScreenOrientationUtil.portraitOnly();
    super.onClose();
  }

  Future<void> _initializeVideoPlayer(videoUrl) async {
    videoLoading.value = true;
    CipherProvider cipherProvider = Get.put(CipherProvider());
    super.onInit();
    debugPrint("urrrrllll: ${videoUrl     }");
    cipherProvider.getvdoCipherData(videoUrl!).then((value) {
      sample_1.value = EmbedInfo.streaming(
        otp: value.otp,
        playbackInfo: value.playbackInfo,
        embedInfoOptions: const EmbedInfoOptions(
          autoplay: true,
        ),
      );
      videoLoading.value = false;
    }).catchError((onError) {
      videoLoading.value = false;
    });
  }

  onFullscreenChange(screenSize) async {
    isFullScreen.value = screenSize;
    if (!screenSize) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
      if (isEnded.value) {
        if (UniversalPlatform.isIOS) {
          controller_vdo.value!.setBackPressCalled();
          update();
          getActivity();
          update();
        }
      }
    }
    update();
  }

  onPlayerCreated(VdoPlayerController? controller) {
    controller_vdo.value = controller;
    controller_vdo.value!.init();
    _onEventChange(controller_vdo.value);
  }

  _onEventChange(VdoPlayerController? controller) {
    controller?.addListener(
      () async {
        vdoPlayerValue.value = controller.value;
        if (UniversalPlatform.isAndroid) {
          if (controller_vdo.value!.value.isEnded) {
            if (isFullScreen.value) {
              controller_vdo.value!.setBackPressCalled();
              update();
              getActivity();
              update();
            } else {
              getActivity();
              // update();
            }
          }
        } else if (UniversalPlatform.isWeb) {
          if (!controller_vdo.value!.value.isPlaying &&
              !controller_vdo.value!.value.isLoading) {
            Duration position = await controller_vdo.value!.getPosition();
            if (isEnded.value == false &&
                    (vdoPlayerValue.value!.duration.inSeconds ==
                        position.inSeconds) ||
                (vdoPlayerValue.value!.duration.inSeconds ==
                    position.inSeconds - 1)) {
              isEnded.value = true;
              if (isFullScreen.value) {
                controller_vdo.value!.setBackPressCalled();
                update();
                getActivity();
                update();
              } else {
                getActivity();
                // update();
              }
            }
          }
        } else {
          if (!controller_vdo.value!.value.isPlaying &&
              !controller_vdo.value!.value.isLoading) {
            Duration position = await controller_vdo.value!.getPosition();
            if (isEnded.value == false &&
                    (vdoPlayerValue.value!.duration.inSeconds ==
                        position.inSeconds) ||
                (vdoPlayerValue.value!.duration.inSeconds ==
                    position.inSeconds - 1)) {
              isEnded.value = true;
              if (!isFullScreen.value) {
                getActivity();
                update();
              }
            }
          }
        }
      },
    );
  }

  void getActivity() async {
    var responses = [];
    if (episode.value?.activity?.id != null) {
      responses = await Future.wait([
        ActivitiesAPIProvider().checkActivityTrackingRequest(
            episode.value?.activity!.id ?? 0, AppConstants.childId ?? -1),
        ActivitiesAPIProvider()
            .makeActivitiesRequest(episode.value!.activity!.id!)
      ]);
      debugPrint('activity id: ${episode.value?.activity}');
      bool isActivityPlayedBefore = responses[0] as bool;
      debugPrint("isActivityPlayedBefore $isActivityPlayedBefore");
      activity = responses[1] as Activity?;
      if (episode.value!.hasQuestions ||
          episode.value!.hasPaintingGame ||
          episode.value!.hasPuzzleGame ||
          episode.value!.hasDragDropGame) {
        videoLoading.value = true;
        playActivitySound();
        debugPrint('has puzzle: ${episode.value!.hasDragDropGame}');

        ///Child hasn't taken the questions before
        ///If there're questions and this questions haven't been played yet let the child take them
        if (episode.value!.hasQuestions && !isActivityPlayedBefore) {
          _toQuestions();
        } else {
          _toGames();
        }
      } else {
        debugPrint('has puzzle: ${episode.value!.hasDragDropGame}');
        videoLoading.value = false;
        Fluttertoast.showToast(
            msg: LocalKeys.kNoActivitiesFound.tr,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: LocalKeys.kNoActivitiesFound.tr,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.newPurple,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void _toQuestions() async {
    videoLoading.value = true;
    if (activity != null) {
      if (UniversalPlatform.isIOS) {
        if (serial?.id != -1) {
          Get.back(result: false);
        } else {
          Get.back();
        }

        Future.delayed(const Duration(milliseconds: 500), () {
          Get.toNamed(Routes.newQuestionsGame, arguments: [
            {LocalKeys.kActivity: activity!},
            {LocalKeys.kPuzzle: episode.value!.hasPuzzleGame},
            {LocalKeys.kPainting: episode.value!.hasPaintingGame},
            {LocalKeys.kDragAndDrop: episode.value!.hasDragDropGame},
            {LocalKeys.kContentType: contentType.value},
            {LocalKeys.kContentId: episode.value?.id.toString()},
            {LocalKeys.kIsAfterEpisode: true},
            {LocalKeys.kIsAfterActivity: false},
            {LocalKeys.kIsFromGamesList: false},
            {LocalKeys.kIsFromBanner: isFromBanner},
            {LocalKeys.kChild: child.value ?? Child()},
            {
              LocalKeys.kIsFromSongsList:
                  episode.value?.contentType == ContentType.song ? true : false
            },
            {LocalKeys.contents: serial ?? Serial()},
          ]);
        });
      } else {
        if (UniversalPlatform.isAndroid) {
          if (serial?.id != -1) {
            if (contentType.value == ContentType.episode) {
              if (UniversalPlatform.isWeb) {
                Get.back();
              } else {
                Get.back();
                Get.back();
              }
            } else {
              if (UniversalPlatform.isWeb) {
                Get.back();
              } else {
                Get.back();
                Get.back();
              }
            }
          } else {
            // if(!UniversalPlatform.isWeb) {
            Get.back();
            // }
          }
          _webToQuestions();
        } else {
          Get.back();
          Future.delayed(const Duration(milliseconds: 300), () {
            _webToQuestions();
          });
        }
      }
    }

    videoLoading.value = false;
  }

  void _toGames() {
    if (UniversalPlatform.isIOS) {
      if (serial?.id != -1) {
        Get.back(result: false);
      } else {
        Get.back();
      }
    } else {
      if (serial?.id != -1) {
        if (contentType.value == ContentType.episode) {
          if (UniversalPlatform.isWeb) {
            Get.back();
          } else {
            Get.back();
            Get.back();
          }
        } else {
          if (UniversalPlatform.isWeb) {
            Get.back();
          } else {
            Get.back();
            Get.back();
          }
        }
      } else {
        // if(!UniversalPlatform.isWeb) {
        Get.back();
        // }
      }
    }
    if (activity != null) {
      if (UniversalPlatform.isIOS) {
        Future.delayed(const Duration(milliseconds: 500), () {
          navigateToActivity();
        });
      } else {
        Future.delayed(const Duration(milliseconds: 0), () {
          navigateToActivity();
        });
      }
    }
    videoLoading.value = false;
  }

  void _webToQuestions() {
    Get.toNamed(Routes.newQuestionsGame, arguments: [
      {LocalKeys.kActivity: activity!},
      {LocalKeys.kPuzzle: episode.value!.hasPuzzleGame},
      {LocalKeys.kPainting: episode.value!.hasPaintingGame},
      {LocalKeys.kDragAndDrop: episode.value!.hasDragDropGame},
      {LocalKeys.kContentType: contentType.value},
      {LocalKeys.kContentId: episode.value?.id.toString()},
      {LocalKeys.kIsAfterEpisode: true},
      {LocalKeys.kIsAfterActivity: false},
      {LocalKeys.kIsFromGamesList: false},
      {LocalKeys.kIsFromBanner: isFromBanner},
      {LocalKeys.kChild: child.value ?? Child()},
      {
        LocalKeys.kIsFromSongsList:
            episode.value?.contentType == ContentType.song ? true : false
      },
      {LocalKeys.contents: serial ?? Serial()},
    ]);
  }

  void navigateToActivity() {
    Get.toNamed(
      Routes.childActivityGames,
      arguments: [
        {LocalKeys.kContentType: contentType.value},
        {LocalKeys.kContentId: episode.value?.id.toString()},
        {
          LocalKeys.kActivity:
              episode.value!.hasQuestions ? activity! : Activity.withError('')
        },
        {LocalKeys.kPuzzle: episode.value!.hasPuzzleGame},
        {LocalKeys.kPainting: episode.value!.hasPaintingGame},
        {LocalKeys.kDragAndDrop: episode.value!.hasDragDropGame},
        {LocalKeys.kRoute: false},
        {LocalKeys.contents: serial},
        {LocalKeys.kChild: child.value},
        {LocalKeys.kAlert: true},
        {"isFromBanner": isFromBanner},
      ],
    );
  }

  void playActivitySound() {
    AudioPlayerUtil.play('letsplay${Random().nextInt(5)}.mp3');
  }
}
