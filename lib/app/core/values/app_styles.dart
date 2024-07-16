import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multimedia_tv_sample/app/core/utils/sizing_extension.dart';

import 'app_colors.dart';

class AppTextStyles {
  static TextStyle headlinesText = TextStyle(
    color: Colors.black,
    fontSize: 20.sp(Get.context!),
    fontWeight: FontWeight.w700,
  );

  static TextStyle headlinesTextSmaller = TextStyle(
    color: Colors.black,
    fontSize: 14.sp(Get.context!),
  );

  static TextStyle headlinesTextLarge = TextStyle(
    fontSize: 24.sp(Get.context!),
    fontWeight: FontWeight.w600,
  );

  static TextStyle parentTextStyle = TextStyle(
    fontSize: 16.sp(Get.context!),
    color: AppColors.parentTextFieldColor,
    fontWeight: FontWeight.bold,
  );

  static TextStyle childTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 16.sp(Get.context!),
    fontWeight: FontWeight.w500,
  );

  static TextStyle childTextStyleSmaller = TextStyle(
    color: Colors.black.withOpacity(.5),
    fontSize: 13.sp(Get.context!),
  );

  static TextStyle childTextStyleSmallest = TextStyle(
    color: Colors.black,
    fontSize: 12.sp(Get.context!),
  );

  static TextStyle childTextStyleBold = TextStyle(
    color: const Color(0xff9e9e9e),
    height: .6,
    fontSize: 15.0.sp(Get.context!),
  );

  static TextStyle pinCodeTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 30.wp(Get.context!),
    height: 1,
    fontWeight: FontWeight.w400,
  );

  static TextStyle boldHeadLineTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 18.wp(Get.context!),
    fontWeight: FontWeight.bold,
  );

  static TextStyle boldHeadLineTextStyleSmaller = TextStyle(
    color: const Color(0xff957b5e),
    fontWeight: FontWeight.w500,
    fontSize: 11.sp(Get.context!),
  );

  static TextStyle pinFieldTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 24.sp(Get.context!),
    height: 1,
    fontWeight: FontWeight.w500,
  );
}
