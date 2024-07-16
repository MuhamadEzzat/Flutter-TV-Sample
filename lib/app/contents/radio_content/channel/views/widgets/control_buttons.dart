import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/audio_handler.dart';
import '../../../../../core/values/app_assets.dart';
import '../../controllers/child_channel_new_controller.dart';

class ControlButtons extends GetView<ChildChannelNewController> {
  List<MediaItem>? queue;
  MediaItem? item;
  ControlButtons({Key? key, required this.queue, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream:
          audioHandler!.playbackState.map((state) => state.playing).distinct(),
      builder: (context, snapshot) {
        bool playing = snapshot.data ?? false;
        return SizedBox(
          width: Get.width * 0.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            textDirection: TextDirection.ltr,
            children: [
              ///Previous Channel
              InkWell(
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          AppAssets.radioPrevious,
                          height: 50,
                          width: 50,
                          fit: BoxFit.fill,
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color:
                                  (item == null || item?.id == queue?.first.id)
                                      ? Colors.grey.withOpacity(0.5)
                                      : null,
                              borderRadius: BorderRadius.circular(25)),
                        ),
                      ],
                    ),
                  ),
                  onTap: () => (item?.id == queue?.first.id || item == null)
                      ? null
                      : controller.previousChannel()),

              ///Backward 10 seconds
              InkWell(
                  child: Image.asset(
                    AppAssets.radioBackward,
                    height: 50,
                    width: 50,
                    fit: BoxFit.fill,
                  ),
                  onTap: () {
                    controller.tenSecondsBackward();
                  }),

              ///Play/pause
              InkWell(
                onTap: item == null ? null : controller.playPause,
                child: Image.asset(
                  playing ? AppAssets.radioPause : AppAssets.radioPlay,
                  height: 45,
                  width: 45,
                  fit: BoxFit.fill,
                ),
              ),

              ///Forward 10 seconds
              InkWell(
                child: Image.asset(
                  AppAssets.radioForward,
                  height: 50,
                  width: 50,
                  fit: BoxFit.fill,
                ),
                onTap: () => controller.tenSecondsForward(),
              ),

              ///Next Channel
              InkWell(
                  onTap: () {
                    debugPrint("queue: $queue");
                    debugPrint("item: $item");
                    (item?.id == queue?.last.id || item == null)
                        ? null
                        : controller.nextChannel();
                  },
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          AppAssets.radioNext,
                          height: 50,
                          width: 50,
                          fit: BoxFit.fill,
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: (item == null || item == queue?.last)
                                  ? Colors.grey.withOpacity(0.5)
                                  : null,
                              borderRadius: BorderRadius.circular(25)),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }
}
