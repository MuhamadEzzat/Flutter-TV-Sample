import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multimedia_tv_sample/app/contents/video_cipher_content/controller/video_cipher_controller.dart';
import 'package:multimedia_tv_sample/app/core/utils/sizing_extension.dart';
import 'package:multimedia_tv_sample/app/shared/shared_bar_controller/shared_bar_controller.dart';
import 'package:multimedia_tv_sample/app/shared/speaker_mute_button.dart';
import 'package:universal_platform/universal_platform.dart';

import '../core/values/app_assets.dart';
import '../core/values/app_colors.dart';
import '../core/values/app_styles.dart';
import '../core/values/localization/local_keys.dart';
import '../data/models/child_model.dart';
import '../routes/app_pages.dart';
import 'child_image.dart';


class SharedWebAppbar extends GetView<VideoCipherController> {
  final bool fromDialog;
  const SharedWebAppbar({this.fromDialog = false, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return UniversalPlatform.isWeb
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 30.wp(context)),
            margin: EdgeInsets.only(bottom: fromDialog ? 0 : 30),
            height: 80,
            width: 100.widthPercentage(context),
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(
                  25,
                ),
                bottomRight: Radius.circular(
                  25,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Color(0xff909090),
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      AppAssets.kWebLogo,
                      height: 55,
                      width: 55,
                    ),
                    SizedBox(
                      width: 15.wp(context),
                    ),
                    InkWell(
                      onTap:(){},
                      child: Container(
                        width: 130,
                        height: 45,
                        decoration: BoxDecoration(
                          color: AppColors.lightBlue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppAssets.kWebHome,
                              height: 25,
                            ),
                            SizedBox(
                              width: 4.wp(context),
                            ),
                            Text(
                              LocalKeys.kMainScreen.tr,
                              style: AppTextStyles.childTextStyle.copyWith(
                                  color: AppColors.newPurple,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.sp(context)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    controller.child != null
                        ? GestureDetector(
                            onTap: (){},
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              height: 36,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ChildImage(
                                    index: 0,
                                    height: 29,
                                    width: 29,
                                    child: Child(),
                                  ),
                                  SizedBox(
                                    height: 8,
                                    width: 14,
                                    child: Image.asset(
                                        AppAssets.kDropDownArrowWhite,
                                        fit: BoxFit.fill),
                                  )
                                ],
                              ),
                            ),
                          )
                        : SizedBox(width: 16.0),
                    const SizedBox(width: 16.0),
                    Obx(
                      () => SpeakerMuteButton(
                        height: 36,
                        width: 36,
                        isMuted: Get.find<SharedBarController>().isMuted.value,
                        onTap:
                            Get.find<SharedBarController>().muteBackgroundMusic,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
