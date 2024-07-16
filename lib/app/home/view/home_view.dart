import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/values/app_colors.dart';
import '../../core/values/localization/local_keys.dart';
import '../../shared/child_loading_widget.dart';
import '../../shared/jeel_rounded_button.dart';
import '../../shared/shared_web_appbar.dart';
import '../controller/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.contextMenu): () =>
            print("Menu button is pressed ..."),
      },
      child: Scaffold(
        backgroundColor: AppColors.lightBlue,
        body: FocusScope(
          autofocus: true,
          onFocusChange: (val) {
            if (val) controller.btnNode1.requestFocus();
          },

          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SharedWebAppbar(
                  fromDialog: true,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.newPurple),
                    color: AppColors.newPurple,
                  ),
                  child: Shortcuts(
                    shortcuts: <LogicalKeySet, Intent>{
                      LogicalKeySet(LogicalKeyboardKey.select):
                      const ActivateIntent(),
                      LogicalKeySet(LogicalKeyboardKey.enter):
                      const ActivateIntent(),
                    },
                    child: TextButton(
                      focusNode: controller.btnNode1,
                      onPressed: () {
                        controller.openVideoPage();
                      },
                      child: Text(LocalKeys.kWatchVideo.tr, style: const TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.newPurple),
                    color: AppColors.newPurple,
                  ),
                  child: TextButton(
                    focusNode: controller.btnNode2,
                    onPressed: () {
                      controller.navigateToBookDetails();
                    },
                    child: Text(LocalKeys.kReadWithJeel.tr, style: const TextStyle(color: Colors.white),),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Obx(
                  () => controller.radioLoading.value
                      ? Center(
                          child: Column(
                            children: [
                              SizedBox(
                                width: 60.w,
                                height: 60.h,
                                child: const ChildLoadingWidget(),
                              ),
                            ],
                          ),
                        )
                      : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: AppColors.newPurple),
                      color: AppColors.newPurple,
                    ),
                        child: TextButton(
                                            focusNode: controller.btnNode3,
                                            onPressed: () {
                        controller.currentChannelIndex.value = 0;
                        controller.toChannel(
                            controller.allRadios.value!.radiosCategories![
                            controller.currentIndex.value],
                            1,
                            controller.currentIndex.value,
                            false);
                                            },
                                            child: Text(LocalKeys.kJeelRadio.tr, style: const TextStyle(color: Colors.white),),
                                          ),
                      ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.newPurple),
                    color: AppColors.newPurple,
                  ),

                  child: TextButton(
                    focusNode: controller.btnNode4,
                    onPressed: () {
                      controller.openHtmlPage();
                    },
                    child: Text(LocalKeys.kChooseGames.tr, style: const TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
