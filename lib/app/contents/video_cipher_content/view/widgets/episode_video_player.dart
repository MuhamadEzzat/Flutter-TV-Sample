import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multimedia_tv_sample/app/contents/video_cipher_content/controller/video_cipher_controller.dart';
import 'package:multimedia_tv_sample/app/core/utils/sizing_extension.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:vdocipher_flutter/vdocipher_flutter.dart';

import '../../../../core/Constants/constants.dart';
import '../../../../core/values/app_assets.dart';


class EpisodeVideoPlayer extends GetView<VideoCipherController> {
  const EpisodeVideoPlayer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isIpad = Get.height > 550;
    bool isWeb = UniversalPlatform.isWeb;

    debugPrint("isAfterGame ${AppConstants.isAfterGame}");

    return isWeb
        ? SizedBox(
            width: 60.widthPercentage(context),
            height: 70.heightPercentage(context),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  AppAssets.kChildTablet,
                  fit: BoxFit.fill,
                  width: 60.widthPercentage(context),
                  height: 70.heightPercentage(context),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 22.5.widthPercentage(context),
                    vertical: 57.hp(context),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(UniversalPlatform.isWeb ? 30 : 15),
                    ),
                    child: VdoPlayer(
                      embedInfo: controller.sample_1.value!,
                      onError: (v) {},
                      onFullscreenChange: controller.onFullscreenChange,
                      onPlayerCreated: controller.onPlayerCreated,
                      controls: true,
                    ),
                  ),
                ),
              ],
            ),
          )
        : AspectRatio(
            aspectRatio: 16 / (isIpad ? 8 : 7),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  AppAssets.kChildTablet,
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: AppConstants.isAfterGame
                      ? EdgeInsets.fromLTRB(isIpad ? 60 : 55, isIpad ? 20 : 11,
                          isIpad ? 60 : 90, isIpad ? 20 : 11)
                      : EdgeInsets.symmetric(
                          horizontal: isIpad ? 60 : 75,
                          vertical: isIpad ? 20 : 10),
                  child: Obx(() => ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      child: VdoPlayer(
                        embedInfo: controller.sample_1.value!,
                        onError: (v) {},
                        onFullscreenChange: controller.onFullscreenChange,
                        onPlayerCreated: controller.onPlayerCreated,
                        controls: true,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
