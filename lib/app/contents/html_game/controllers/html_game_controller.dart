import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/utils/audio_player_utils.dart';
import '../../../core/utils/screen_orientation_util.dart';


class HtmlGameController extends GetxController with WidgetsBindingObserver {
  final dynamic arguments = Get.arguments;
  String? gameURL;
  String? gameName;

  // TrackingBloc? trackingBloc;

  @override
  void onInit() {
    super.onInit();
    ScreenOrientationUtil.landscapeFromPortrait();
    gameURL = arguments[0]["gameURL"] as String;
    gameName = arguments[1]["gameName"] as String;
    AudioPlayerUtil.enterVideoMode();
  }

  Future<bool> onWillPop() async {
    ScreenOrientationUtil.portraitOnly();
    Get.back();

    return Future.value(true);
  }

  goBack() {
    ScreenOrientationUtil.portraitOnly();

    Get.back();
  }
}
