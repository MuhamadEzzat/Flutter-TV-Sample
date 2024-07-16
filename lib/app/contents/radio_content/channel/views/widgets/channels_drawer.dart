import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multimedia_tv_sample/app/core/utils/sizing_extension.dart';
import 'package:rxdart/rxdart.dart' as rx_dart;

import '../../../../../core/utils/audio_handler.dart';
import '../../../../../core/utils/audio_player_utils.dart';
import '../../../../../core/values/app_assets.dart';
import '../../../../../core/values/app_colors.dart';
import '../../../../../shared/animated_column.dart';
import '../../controllers/child_channel_new_controller.dart';
import 'channel_drawer_card.dart';

class ChannelsDrawer extends GetView<ChildChannelNewController> {
  const ChannelsDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isIpad = Get.height > 550;
    return StreamBuilder<QueueState>(
        stream: _queueStateStream,
        builder: (context, snapshot) {
          final queueState = snapshot.data;
          final mediaItem = queueState?.mediaItem;
          if (mediaItem == null) {
            return Container();
          }
          WidgetsBinding.instance.addPostFrameCallback((_) {
            controller.currentChannelIndex.value =
                controller.radio.value!.channels!.indexWhere((ch) =>
                    (AudioPlayerUtil.isMusicAllowed
                        ? ch.trackWithMusic
                        : ch.trackWithoutMusic) ==
                    mediaItem.id);
          });
          return SizedBox(
            width: Get.width / 1.8, //520.wp(context),
            child: Drawer(
              backgroundColor: AppColors.lightBlue,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 40, 24, 8),
                child: AnimatedColumn(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.radio.value?.name ?? "",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => controller.dismissChannelsDialog(),
                          child: SizedBox(
                            height: 24.hp(context),
                            width: 24.wp(context),
                            child: Image.asset(AppAssets.kClose,
                                fit: BoxFit.contain),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    GridView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount:
                            controller.radio.value?.channels?.length ?? 0,
                        //controller.radio.value?.channels?.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: isIpad ? 160 : 130,
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: isIpad ? 20 : 5,
                        ),
                        itemBuilder: (context, sectionItem) {
                          debugPrint(
                              "isLoading? ${sectionItem > audioHandler!.queue.value.length - 1}");
                          return GestureDetector(
                            onTap: () {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                sectionItem > queueState!.queue!.length - 1
                                    ? null
                                    : controller.openChannelFromDrawer(
                                        sectionItem, true);
                              });
                            },
                            child: Obx(() {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                controller.currentChannelIndex.value =
                                    audioHandler!.index!;
                              });

                              return ChannelDrawerCard(
                                isSelected:
                                    controller.currentChannelIndex.value ==
                                        sectionItem,
                                // channel: mediaItem,
                                channel: (controller
                                    .radio.value!.channels![sectionItem]),
                                isFree: controller
                                    .radio.value!.channels![sectionItem].isFree,
                                isLoading: sectionItem >
                                    audioHandler!.queue.value.length - 1,
                              );
                            }),
                          );
                        }),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class QueueState {
  final List<MediaItem>? queue;
  final MediaItem? mediaItem;

  QueueState(this.queue, this.mediaItem);
}

Stream<QueueState> get _queueStateStream =>
    rx_dart.Rx.combineLatest2<List<MediaItem>?, MediaItem?, QueueState>(
        audioHandler!.queue,
        audioHandler!.mediaItem,
        (queue, mediaItem) => QueueState(queue, mediaItem));
