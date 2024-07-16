import 'package:audio_service/audio_service.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multimedia_tv_sample/app/core/utils/sizing_extension.dart';
import '../../../../../core/utils/audio_handler.dart';
import '../../../../../core/values/app_assets.dart';
import '../../../../../core/values/app_colors.dart';
import '../../controllers/child_channel_new_controller.dart';
import 'control_buttons.dart';
import 'my_slider.dart';

class MyAudioPlayer extends GetView<ChildChannelNewController> {
  const MyAudioPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MediaItem?>(
        stream: audioHandler!.mediaItem,
        builder: (context, mediaItemSnapshot) {
          final mediaItem = mediaItemSnapshot.data;
          // controller.trackRadioChannel();
          return SizedBox(
            height: (Get.width),
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: (Get.width * 0.2 - 45).hp(context),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          AppAssets.kSoundWaveNew,
                          width: (Get.width).hp(context),
                          height: 78.wp(context),
                          fit: BoxFit.fill,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: ClipRRect(
                            child: SizedBox(
                              width: (Get.width * 0.2).wp(context),
                              height: (Get.width * 0.2).hp(context),
                              child: Stack(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:
                                        mediaItem?.artUri.toString() ?? "",
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AutoSizeText(
                    mediaItem?.title ?? '',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 32.sp(context),
                        color: AppColors.newPurple),
                    textAlign: TextAlign.center,
                  ),
                  AutoSizeText(
                    controller.radio.value?.name ?? "",
                    maxFontSize: 16,
                    minFontSize: 12,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, color: Color(0xff121212)),
                    textAlign: TextAlign.center,
                  ),
                  const MySlider(),
                  ControlButtons(
                      queue: audioHandler!.queue.value, item: mediaItem),
                ],
              ),
            ),
          );
        });
  }
}
