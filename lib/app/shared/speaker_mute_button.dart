import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/utils/audio_player_utils.dart';
import '../core/values/app_assets.dart';

class SpeakerMuteButton extends StatelessWidget {
  final double height;
  final double width;
  final bool isMuted;
  final Function onTap;

  const SpeakerMuteButton({
    Key? key,
    required this.height,
    required this.width,
    required this.isMuted,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            AppAssets.kChildReportBg,
            semanticsLabel: 'Acme Logo',
            width: height,
            height: width,
            color: const Color(0xffffffff),
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: height / (3 / 2),
            width: width / (3 / 2),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(height / 3),
              child: Image.asset(
                  AudioPlayerUtil.isMuted()
                      ? AppAssets.kSpeakerMutedPurple
                      : AppAssets.kSpeakerUnMutedPurple,
                  fit: BoxFit.fill),
            ),
          ),
          AudioPlayerUtil.isMuted()
              ? SizedBox(
                  height: height / (3 / 2),
                  width: width / (3 / 2),
                  child: ClipRRect(
                    //borderRadius: BorderRadius.circular(height / 3),
                    child:
                        Image.asset(AppAssets.kIgnoreSlash, fit: BoxFit.fill),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
