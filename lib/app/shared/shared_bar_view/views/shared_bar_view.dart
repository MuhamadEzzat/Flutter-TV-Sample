import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multimedia_tv_sample/app/shared/shared_bar_view/views/widgets/channel_bar_view.dart';
import 'package:multimedia_tv_sample/app/shared/shared_bar_view/views/widgets/episode_bar_view.dart';
import 'package:multimedia_tv_sample/app/shared/shared_bar_view/views/widgets/home_bar_view.dart';
import 'package:multimedia_tv_sample/app/shared/shared_bar_view/views/widgets/questions_bar_view.dart';
import 'package:multimedia_tv_sample/app/shared/shared_bar_view/views/widgets/section_bar_view.dart';

import '../../../data/enums/content_type.dart';
import '../../../data/models/child_model.dart';
import '../../../data/models/radio_model.dart';
import '../../shared_bar_controller/shared_bar_controller.dart';

class SharedBarView extends GetView<SharedBarController> {
  final Child? child;
  final bool isHome;
  final bool isSection;
  final bool isEpisode;
  final bool isQuestion;
  final bool isDynamicSection;
  final bool isMuteButtonEnabled;
  final String? contentName;
  final String? contentIcon;
  final RadioModel? radio;
  final Function? onBackTap;
  final int? radioIndex;
  final ContentType? contentType;
  final bool? hasIntro;

  const SharedBarView(
      {Key? key,
      required this.child,
      required this.radio,
      required this.isMuteButtonEnabled,
      required this.isQuestion,
      required this.isHome,
      required this.isSection,
      required this.hasIntro,
      required this.isEpisode,
      required this.isDynamicSection,
      required this.contentType,
      this.radioIndex,
      required this.contentIcon,
      required this.contentName,
      required this.onBackTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.child.value = child;
    controller.contentType.value = contentType;
    debugPrint('Child Data: ${controller.child.value}');

    return isHome
        ? Obx(
            () => HomeBarView(
              child: child,
              openChildInfoOnTap: (){},
              isMuted: controller.isMuted.value,
              muteOnTap: controller.muteBackgroundMusic,
            ),
          )
        : isSection
            ? Obx(
                () => SectionBarView(
                  contentName: contentName ?? '',
                  openChildInfoOnTap: (){},
                  isMuted: controller.isMuted.value,
                  muteOnTap: isMuteButtonEnabled
                      ? controller.muteBackgroundMusic
                      : () {},
                  backOnTap: controller.onBackTap,
                  openChangeCategoriesDialog: () {

                  },
                  contentIcon: contentIcon,
                  isDynamicSection: isDynamicSection,
                  hasIntro: hasIntro ?? false,
                  child: child ?? Child(),
                ),
              )
            : isEpisode
                ? EpisodeBarView(
                    backOnTap: onBackTap ?? controller.onBackEpisodeTap,
                    // isMuteButtonEnabled
                    //     ? () => controller.onBackEpisodeTap()
                    //     : () => onBackTap!(),
                  )
                : isQuestion
                    ? Obx(
                        () => QuestionsBarView(
                            backOnTap: () {
                              onBackTap!();
                            },
                            muteOnTap: () => controller.muteBackgroundMusic(),
                            isMuted: controller.isMuted.value),
                      )
                    : ChannelBarView(
                        backOnTap: () => controller.onBackChannel(radioIndex!),
                        name: contentName,
                        image: contentIcon,
                        onTap: controller.openRadioList,
                        radio: radio!,
                      );
  }
}
