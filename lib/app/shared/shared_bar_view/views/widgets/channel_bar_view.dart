import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multimedia_tv_sample/app/core/utils/sizing_extension.dart';

import '../../../../core/values/app_assets.dart';
import '../../../../data/models/radio_model.dart';

class ChannelBarView extends StatelessWidget {
  final Function backOnTap;
  final Function onTap;
  final String? name;
  final String? image;
  final RadioModel radio;
  const ChannelBarView({
    Key? key,
    required this.backOnTap,
    required this.name,
    required this.image,
    required this.onTap,
    required this.radio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isAr = Get.locale?.languageCode == "ar";
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AnimatedContainer(
          duration: const Duration(seconds: 7),
          width: 155.wp(context),
          height: 35.hp(context),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: GestureDetector(
            onTap: () => {Scaffold.of(context).openDrawer()},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  image ?? '',
                  height: 32.hp(context),
                  width: 30.wp(context),
                ),
                Expanded(
                  child: SizedBox(
                    width: 100,
                    child: AutoSizeText(
                      name ?? '',
                      maxFontSize: 16,
                      minFontSize: 12,
                      maxLines: 1,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_right,
                  color: Colors.white,
                  size: 30,
                )
              ],
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        GestureDetector(
          onTap: () => backOnTap(),
          child: Image.asset(
            isAr
                ? AppAssets.kBackButtonWhitePurpleBG
                : AppAssets.kBackButtonWhitePurpleBGEn,
            height: 36.hp(context),
            width: 36.wp(context),
          ),
        )
      ],
    );
  }
}
