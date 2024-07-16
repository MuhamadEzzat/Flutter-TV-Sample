import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multimedia_tv_sample/app/core/utils/sizing_extension.dart';

import '../../../../core/values/app_assets.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../data/models/child_model.dart';
import '../../../child_image.dart';
import '../../../speaker_mute_button.dart';

class SectionBarView extends StatelessWidget {
  final String contentName;
  final Child? child;
  final Function openChildInfoOnTap;
  final bool isMuted;
  final Function muteOnTap;
  final Function backOnTap;
  final Function openChangeCategoriesDialog;
  final String? contentIcon;
  final bool isDynamicSection;
  final bool hasIntro;

  const SectionBarView({
    Key? key,
    required this.contentName,
    required this.child,
    required this.openChildInfoOnTap,
    required this.isMuted,
    required this.muteOnTap,
    required this.backOnTap,
    required this.openChangeCategoriesDialog,
    required this.contentIcon,
    required this.isDynamicSection,
    required this.hasIntro,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isAr = Get.locale?.languageCode == "ar";
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: isDynamicSection
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      AppAssets.kLogoWithHint,
                      height: 44.hp(context),
                      width: 44.wp(context),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(seconds: 7),
                      width: 155.wp(context),
                      height: 35.hp(context),
                      decoration: BoxDecoration(
                          color: AppColors.lightsBlue,
                          borderRadius: BorderRadius.circular(15)),
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: GestureDetector(
                        onTap: () => openChangeCategoriesDialog(),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              contentIcon ?? '',
                              height: 32.hp(context),
                              width: 30.wp(context),
                            ),
                            Expanded(
                              child: SizedBox(
                                width: 100,
                                child: AutoSizeText(
                                  contentName,
                                  maxFontSize: 14,
                                  minFontSize: 6,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff121212),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Image.asset(
                              isAr
                                  ? AppAssets.kBlackArrowBannerLeft
                                  : AppAssets.kBlackArrowBannerRight,
                              height: 24.hp(context),
                              width: 20.wp(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
        const SizedBox(width: 16.0),
        child?.id != -1
            ? GestureDetector(
                onTap: () {
                  openChildInfoOnTap();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  height: 36,
                  width: 70,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ChildImage(
                        index: 0,
                        height: 29,
                        width: 29,
                        child: child ?? Child(),
                      ),
                      SizedBox(
                        height: 8,
                        width: 14,
                        child: Image.asset(AppAssets.kDropDownArrowWhite,
                            fit: BoxFit.fill),
                      )
                    ],
                  ),
                ),
              )
            : SizedBox(width: hasIntro ? 0.0 : 16.0),
        SizedBox(width: hasIntro ? 0.0 : 16.0),
        hasIntro
            ? const SizedBox.shrink()
            : SpeakerMuteButton(
                height: 36.hp(context),
                width: 36.wp(context),
                isMuted: isMuted,
                onTap: muteOnTap,
              ),
        const SizedBox(width: 16.0),

      ],
    );
  }
}
