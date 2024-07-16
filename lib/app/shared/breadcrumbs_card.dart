import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multimedia_tv_sample/app/core/utils/sizing_extension.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../../app_navigation_observer.dart';
import '../core/utils/audio_player_utils.dart';
import '../core/values/app_assets.dart';
import '../core/values/app_colors.dart';
import '../core/values/app_styles.dart';


class BreadCrumbsCard extends StatelessWidget {
  final bool? isSeries;
  const BreadCrumbsCard({Key? key, this.isSeries = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UniversalPlatform.isWeb
            ? Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.wp(context),
                ),
                child: Obx(
                  () => SizedBox(
                    height: 30,
                    child: Row(
                      children: List<Widget>.from(routeStack
                          .asMap()
                          .map(
                            (index, value) => MapEntry(
                              index,
                              GestureDetector(
                                onTap: () {
                                  AudioPlayerUtil.exitVideoMode();
                                  Get.offNamedUntil(
                                      routeStack[index].settings.name!,
                                      (route) => route == routeStack[index]);
                                  // // Navigator.popUntil(context,
                                  // //     (route) => route == routeStack[index]);
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    index == 0
                                        ? Image.asset(
                                            AppAssets.kWebHomeIcon,
                                            height: 20,
                                          )
                                        : Text(
                                            routeName(
                                                routeStack[index], isSeries),
                                            style: AppTextStyles.headlinesText
                                                .copyWith(
                                              color: AppColors.newPurple,
                                              fontSize: 14,
                                            ),
                                          ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    index + 1 == routeStack.length
                                        ? const SizedBox.shrink()
                                        : Image.asset(
                                            AppAssets.kWebBackBreadcrumbs,
                                            height: 15,
                                          ),
                                    SizedBox(
                                      width: index + 1 == routeStack.length
                                          ? 0
                                          : 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .values),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        SizedBox(
          height: UniversalPlatform.isWeb ? 30 : 0,
        )
      ],
    );
  }
}
