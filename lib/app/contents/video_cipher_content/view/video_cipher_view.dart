import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:multimedia_tv_sample/app/contents/video_cipher_content/view/widgets/episode_video_player.dart';
import 'package:multimedia_tv_sample/app/core/utils/sizing_extension.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../../core/utils/audio_player_utils.dart';
import '../../../core/values/app_assets.dart';
import '../../../core/values/app_colors.dart';
import '../../../data/models/child_model.dart';
import '../../../shared/breadcrumbs_card.dart';
import '../../../shared/child_loading_widget.dart';
import '../../../shared/shared_bar_view/views/shared_bar_view.dart';
import '../../../shared/shared_web_appbar.dart';
import '../controller/video_cipher_controller.dart';

class VideoCipherView extends GetView<VideoCipherController> {
  const VideoCipherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isAr = Get.locale?.languageCode == "ar";
    bool isIpad = Get.height > 550;
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: Scaffold(
        backgroundColor: AppColors.lightBlue,
        appBar: UniversalPlatform.isWeb
            ? null
            : AppBar(
          toolbarHeight: 0,
          backgroundColor: AppColors.newPurple,
          elevation: 0.0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SharedWebAppbar(),
            const BreadCrumbsCard(),
            Expanded(
              child: Container(
                padding: UniversalPlatform.isWeb
                    ? EdgeInsets.symmetric(
                  horizontal: 30.wp(context),
                )
                    : null,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      AppAssets.kChildNewBgLandscape,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UniversalPlatform.isWeb
                          ? const SizedBox.shrink()
                          : Padding(
                        padding: const EdgeInsets.fromLTRB(
                            8.0, 8.0, 8.0, 0.0),
                        child: SharedBarView(
                            onBackTap: controller.onWillPop,
                            radio: null,
                            isQuestion: false,
                            child: Child(),
                            isHome: false,
                            isSection: false,
                            isEpisode: true,
                            isDynamicSection: false,
                            contentName: null,
                            contentIcon: '',
                            isMuteButtonEnabled: true,
                            contentType: null,
                            hasIntro: false,
                          ),
                        ),
                      Expanded(
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Positioned(
                              bottom: -10,
                              top: UniversalPlatform.isWeb
                                  ? Get.height - 350
                                  : null,
                              left: isAr
                                  ? UniversalPlatform.isWeb
                                  ? -10
                                  : -60
                                  : 0,
                              right: isAr
                                  ? 0
                                  : UniversalPlatform.isWeb
                                  ? -10
                                  : -60,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 144.hp(context),
                                    width: UniversalPlatform.isWeb
                                        ? 220
                                        : 250.wp(context),
                                    child: Image.asset(
                                      isAr
                                          ? AppAssets.kBoyWatchingCloud
                                          : AppAssets.kBoyWatchingCloudEn,
                                      fit: UniversalPlatform.isWeb
                                          ? null
                                          : BoxFit.contain,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 144.hp(context),
                                    width: UniversalPlatform.isWeb
                                        ? 220
                                        : 250.wp(context),
                                    child: Image.asset(
                                      isAr
                                          ? AppAssets.kGirlWatchingCloud
                                          : AppAssets
                                          .kGirlWatchingCloudEn,
                                      fit: UniversalPlatform.isWeb
                                          ? null
                                          : BoxFit.contain,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: UniversalPlatform.isWeb
                                  ? 0
                                  : isIpad
                                  ? 10
                                  : 60.hp(context),
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Padding(
                                padding: UniversalPlatform.isWeb
                                    ? EdgeInsets.zero
                                    : isIpad
                                    ? EdgeInsets.symmetric(
                                    horizontal: 70.0.hp(context),
                                    vertical: 85.hp(context))
                                    : EdgeInsets.symmetric(
                                    horizontal:
                                    100.0.hp(context)),
                                child: Obx(() => controller.sample_1.value == null ? Center(
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 90),
                                      SizedBox(
                                        width: 200.w,
                                        height: 200.h,
                                        child: const ChildLoadingWidget(),
                                      ),
                                    ],
                                  ),
                                ) : const EpisodeVideoPlayer())

                              ),
                            ),
                          ],
                        ),
                      ),
                      //if (controller.signedVideoUrl?.value != null)
                    ],

                    //if (controller.signedVideoUrl?.value != null)
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
