import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:multimedia_tv_sample/app/core/utils/sizing_extension.dart';

import '../../../../../core/Constants/constants.dart';
import '../../../../../core/values/app_assets.dart';
import '../../../../../data/models/episode_model.dart';

class ChannelSectionCard extends StatelessWidget {
  final Episode? episode;
  final bool isSelected;

  const ChannelSectionCard(
      {required this.episode, Key? key, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Stack(
          children: [
            isSelected
                ? Center(
                    child: SizedBox(
                      height: 120.h,
                      width: 120.w,
                      child: Image.asset(AppAssets.kSectionSelectedBg,
                          fit: BoxFit.fill),
                    ),
                  )
                : SizedBox(
                    height: 110.h,
                    width: 110.w,
                    child: Image.asset(AppAssets.kSectionUnSelectedBg,
                        fit: BoxFit.fill),
                  ),
            Center(
              child: Container(
                margin: const EdgeInsetsDirectional.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                height: 85.hp(context),
                width: 85.wp(context),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      episode?.image ?? AppConstants.errorImage,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ],
        )),
        SizedBox(
          height: 5.hp(context),
        ),
        AutoSizeText(
          Get.locale?.languageCode == "ar"
              ? episode?.name ?? ''
              : episode?.name ?? '',
          maxFontSize: 14,
          minFontSize: 12,
          style: const TextStyle(
              fontWeight: FontWeight.w700, color: Color(0xff121212)),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
