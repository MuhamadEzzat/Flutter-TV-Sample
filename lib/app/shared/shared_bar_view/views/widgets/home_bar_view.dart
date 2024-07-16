import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/values/app_assets.dart';
import '../../../../data/models/child_model.dart';
import '../../../child_image.dart';
import '../../../speaker_mute_button.dart';

class HomeBarView extends StatelessWidget {
  final Child? child;
  final Function openChildInfoOnTap;
  final bool isMuted;
  final Function muteOnTap;

  const HomeBarView(
      {Key? key,
      required this.child,
      required this.openChildInfoOnTap,
      required this.isMuted,
      required this.muteOnTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  AppAssets.kLogoWithHint,
                  height: 44,
                  width: 42,
                ),
              ],
            ),
          ),
          child != null
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
                          child: child!,
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
              : SizedBox(width: 16.0),
          const SizedBox(width: 16.0),
          SpeakerMuteButton(
            height: 36,
            width: 36,
            isMuted: isMuted,
            onTap: muteOnTap,
          ),
        ],
      ),
    );
  }
}
