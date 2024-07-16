import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:universal_platform/universal_platform.dart';

class ScreenOrientationUtil {
  static const channel = MethodChannel('jeel/orentation');

  static Future portraitOnly() async {
    if (!UniversalPlatform.isWeb) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarBrightness: Brightness.light));
//    await SystemChrome.setEnabledSystemUIOverlays([]);
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
      // FlutterStatusbarcolor.setStatusBarColor(Colors.black.withOpacity(.3));
      debugPrint("portrait called ended");
    }
  }

  static void landscape() async {
    if (!UniversalPlatform.isWeb) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
      // FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    }
  }

  static Future landscapeFromPortrait() async {
    if (!UniversalPlatform.isWeb) {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
      // FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
      debugPrint("landscapeFromPortrait called ended");
      debugPrint("orientation ${MediaQuery.of(Get.context!).orientation.name}");
    }
  }
}
