import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multimedia_tv_sample/app/core/utils/sizing_extension.dart';

import '../../../../core/values/app_assets.dart';

class EpisodeBarView extends StatelessWidget {
  final Function backOnTap;

  const EpisodeBarView({
    Key? key,
    required this.backOnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isAr = Get.locale?.languageCode == "ar";
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            AppAssets.kLogoWithHint,
            height: 44.hp(context),
            width: 44.wp(context),
          ),
          const SizedBox(width: 16.0),

        ],
      ),
    );
  }
}
