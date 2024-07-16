import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/Constants/constants.dart';
import '../../core/utils/audio_player_utils.dart';
import '../../core/utils/screen_orientation_util.dart';
import '../../data/enums/content_type.dart';
import '../../data/models/child_model.dart';

class SharedBarController extends GetxController with WidgetsBindingObserver {
  Rxn<ContentType> contentType = Rxn<ContentType>();
  Rxn<Child> child = Rxn<Child>();
  RxnInt childId = RxnInt();
  RxBool isMuted = false.obs;
  int radioIndex = 0;

  @override
  void onInit() {
    super.onInit();

    if (child.value != null) {

      AppConstants.childId = child.value?.id;
    }
    if (AppConstants.childId != null && AppConstants.childId != -1) {
      AppConstants.isAnonymous = false;
    }
  }

  // //Banner Actions
  // void openChildInfoOnTap() {
  //   Get.dialog(
  //     const Center(
  //       child: SelectUserDialog(),
  //     ),
  //   );
  // }

  void muteBackgroundMusic() {
    AudioPlayerUtil.muteOrUnmuteBackgroundMusic();

    isMuted.value = AudioPlayerUtil.isMuted();
    // isMuted.value ? AudioPlayerUtil.enterVideoMode() : AudioPlayerUtil.exitVideoMode();
  }

  void onBackEpisodeTap() {
    Get.back();
  }

  void onBackChannel(int index) {
    Get.back(result: index);
  }

  void onBackTap() {
    AudioPlayerUtil.exitVideoMode();
    Get.back();
  }

  void onBackQuestionTap(bool isAfterActivity) {
    if (isAfterActivity) {
      Get.back();
    }
    Get.back();
  }

  // void openChangeCategoriesDialog(BuildContext context, ContentType sectionId) {
  //   Get.dialog(
  //     Center(
  //       child: CategoriesChangeView(
  //           contentType: contentType.value ?? ContentType.normalSerial,
  //           child: child.value),
  //     ),
  //   );
  // }

  void openRadioList() {}
}
