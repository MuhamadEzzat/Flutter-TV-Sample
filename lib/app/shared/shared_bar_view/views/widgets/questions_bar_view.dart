import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multimedia_tv_sample/app/core/utils/sizing_extension.dart';

import '../../../../core/values/app_assets.dart';
import '../../../speaker_mute_button.dart';

class QuestionsBarView extends StatelessWidget {
  final Function backOnTap;
  final Function muteOnTap;
  final bool isMuted;

  const QuestionsBarView({
    Key? key,
    required this.backOnTap,
    required this.muteOnTap,
    required this.isMuted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                AppAssets.kLogoWithHint,
                height: 44,
                width: 44.wp(context),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16.0),
        SpeakerMuteButton(
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
