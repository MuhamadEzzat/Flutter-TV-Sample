import 'package:audio_service/audio_service.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multimedia_tv_sample/app/contents/radio_content/channel/views/widgets/build_audio.dart';
import 'package:multimedia_tv_sample/app/contents/radio_content/channel/views/widgets/channels_drawer.dart';
import 'package:multimedia_tv_sample/app/core/utils/sizing_extension.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../../../core/utils/audio_handler.dart';
import '../../../../core/values/app_assets.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../shared/shared_bar_view/views/shared_bar_view.dart';
import '../controllers/child_channel_new_controller.dart';

class ChildChannelNewView extends GetView<ChildChannelNewController> {
  const ChildChannelNewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    bool isIpad = Get.height > 550;
    bool isAr = Get.locale?.languageCode == "ar";
    return StreamBuilder<MediaItem?>(
        stream: audioHandler!.mediaItem,
        builder: (context, mediaItemSnapshot) {
          final mediaItem = mediaItemSnapshot.data;

          return WillPopScope(
            onWillPop: controller.onWillPop,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: AppColors.lightBlue,
                drawer: const ChannelsDrawer(),
                appBar: AppBar(
                  leadingWidth: Get.width,
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(() {
                      return SharedBarView(
                        onBackTap: null,
                        radio: controller.radio.value,
                        isQuestion: false,
                        child: null,
                        isHome: false,
                        isSection: false,
                        isEpisode: false,
                        isDynamicSection: false,
                        hasIntro: false,
                        contentName: mediaItem?.title,
                        contentIcon: mediaItem?.artUri.toString(),
                        isMuteButtonEnabled: true,
                        radioIndex: controller.currentFixedIndex,
                        contentType: null,
                      );
                    }),
                  ),
                  toolbarHeight: 60,
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                ),
                body: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        AppAssets.kChildNewBgLandscape,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        left: isAr ? -60 : -20,
                        right: isAr ? -20 : -60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 144.hp(context),
                              width: 280.hp(context),
                              child: Image.asset(
                                isAr
                                    ? AppAssets.kRadioBoyCloud
                                    : AppAssets.kRadioBoyCloudEn,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(
                              height: 144.hp(context),
                              width: 280.hp(context),
                              child: Image.asset(
                                isAr
                                    ? AppAssets.kRadioGirlCloud
                                    : AppAssets.kRadioGirlCloudEn,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                       BuildAudio()
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
