import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/values/app_assets.dart';
import '../../controllers/child_channel_new_controller.dart';
import 'my_audio_player.dart';

class BuildAudio extends GetView<ChildChannelNewController> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.kChildNewBg),
              fit: BoxFit.contain,
            ),
          ),
          child: const MyAudioPlayer()),
    );
  }
}
