import 'package:audio_service/audio_service.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multimedia_tv_sample/app/core/utils/sizing_extension.dart';

import '../../../../../core/Constants/constants.dart';
import '../../../../../core/values/app_colors.dart';
import '../../../../../core/values/localization/local_keys.dart';
import '../../../../../data/models/channel_model.dart';

class ChannelDrawerCard extends StatelessWidget {
  final Channel channel;
  final bool isSelected;
  final bool isFree;
  final bool isLoading;

  const ChannelDrawerCard({
    Key? key,
    required this.isSelected,
    required this.channel,
    required this.isFree,
    required this.isLoading,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isIpad = Get.width > 550;
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: AppColors.white,
                border: Border.all(
                  color: isSelected ? AppColors.newPurple : AppColors.white,
                  width: isSelected ? 2 : 0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isSelected
                        ? AppColors.newPurple.withOpacity(.7)
                        : AppColors.blueShadow,
                    spreadRadius: .5,
                    blurRadius: 1,
                    offset: const Offset(-1, 3),
                  ),
                ],
              ),
              height: 91.hp(context),
              width: 175.wp(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isSelected
                      ? const Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                              10,
                              0,
                              0,
                              0,
                            ),
                            child: Icon(
                              Icons.check_circle,
                              color: AppColors.newPurple,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  Image.network(
                    channel.image.toString() ?? '',
                    height: 55.hp(context),
                  ),
                ],
              ),
            ),
            if (!isFree && !AppConstants.isPaidUser)
              const Icon(
                Icons.lock,
                color: Colors.white,
                size: 48,
              ),
            isLoading
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.black.withOpacity(0.3),
                    ),
                    height: 91.hp(context),
                    width: 175.wp(context),
                    child: Center(
                      child: AutoSizeText(
                        LocalKeys.kLoading.tr,
                        maxFontSize: 16,
                        minFontSize: 12,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight:
                              isSelected ? FontWeight.w800 : FontWeight.w500,
                          //fontSize: 15.sp(context),
                          color: Colors.white,
                          fontFamily: "PingAr",
                        ),
                      ),
                    ))
                : const SizedBox.shrink(),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        AutoSizeText(
          channel.name ?? '',
          maxFontSize: 16,
          minFontSize: 12,
          maxLines: 1,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
            //fontSize: 15.sp(context),
            color: isSelected ? AppColors.newPurple : Colors.black,
            fontFamily: "PingAr",
          ),
        ),
      ],
    );
  }
}
