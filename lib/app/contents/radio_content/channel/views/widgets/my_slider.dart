import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart' as rx_dart;
import '../../../../../core/utils/audio_handler.dart';
import '../../../../../core/values/app_colors.dart';
import '../../controllers/child_channel_new_controller.dart';

class MySlider extends GetView<ChildChannelNewController> {
  const MySlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MediaState?>(
      stream: _mediaStateStream,
      builder: (context, snapshot) {
        final mediaState = snapshot.data;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.playedTime.value =
              mediaState?.position.inSeconds.toDouble() ?? 0.0;
          controller.audioTotalTime.value =
              (mediaState?.mediaItem?.duration?.inSeconds.toDouble() ?? 0);
        });
        if (snapshot.data == null ||
            snapshot.connectionState != ConnectionState.active) {
          return const SizedBox();
        } else {
          return Obx(() => Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                textDirection: TextDirection.ltr,
                children: [
                  Text(
                    '${(controller.playedTime.value / 60).floor().toString().padLeft(2, '0')}'
                    ':${(controller.playedTime.value % 60).floor().toString().padLeft(2, '0')}',
                    style: TextStyle(
                        color: AppColors.newPurple,
                        fontSize: 16.sp,
                        fontFamily: "PingAr",
                        fontWeight: FontWeight.w500),
                  ),
                  Transform.translate(
                    offset: const Offset(0.0, -3.0),
                    child: SizedBox(
                      width: (Get.width * 0.5).h,
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Slider(
                          value: controller.playedTime.value,
                          onChanged: (value) =>
                              controller.changePlayedTime(value.toInt()),
                          onChangeEnd: (value) =>
                              controller.changePlayedTime(value.toInt()),
                          min: 0.0,
                          max: controller.audioTotalTime.value,
                          label:
                              '${(controller.playedTime.value / 60).floor().toString().padLeft(2, '0')}:${(controller.playedTime.value % 60).toString().padLeft(2, '0')}',
                          divisions: controller.audioTotalTime.value == 0.0
                              ? 1
                              : controller.audioTotalTime.value.toInt() * 60,
                          activeColor: AppColors.newPurple,
                          inactiveColor: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '${(controller.audioTotalTime.value / 60).floor().toString().padLeft(2, '0')}:${(controller.audioTotalTime.value % 60).floor().toString().padLeft(2, '0')}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontFamily: "PingAr",
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ));
        }
      },
    );
  }
}

class MediaState {
  final MediaItem? mediaItem;
  final Duration position;

  MediaState(this.mediaItem, this.position);
}

Stream<MediaState> get _mediaStateStream =>
    rx_dart.Rx.combineLatest2<MediaItem?, Duration, MediaState>(
        audioHandler!.mediaItem,
        AudioService.position,
        (mediaItem, position) => MediaState(mediaItem, position));
