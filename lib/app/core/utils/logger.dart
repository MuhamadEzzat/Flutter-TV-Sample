import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

class LogUtils {
  static const String kTAG = "New Gene:";

  static log(dynamic msg, {String tag = kTAG}) {
    if (!kReleaseMode) {
      developer.log('$msg', name: tag);
    }
  }

  ///Singleton factory
  static final LogUtils _instance = LogUtils._internal();

  factory LogUtils() {
    return _instance;
  }

  LogUtils._internal();
}
