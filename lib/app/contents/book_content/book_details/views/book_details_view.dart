import 'package:flip_board/flip_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:multimedia_tv_sample/app/contents/book_content/book_details/views/widgets/item_builder.dart';
import 'package:multimedia_tv_sample/app/contents/book_content/book_details/views/widgets/next_page_button.dart';
import 'package:multimedia_tv_sample/app/contents/book_content/book_details/views/widgets/previous_page_button.dart';
import '../../../../core/Constants/constants.dart';
import '../../../../core/values/app_assets.dart';
import '../../../../core/values/localization/local_keys.dart';
import '../../../../shared/back_button_new_purple.dart';
import '../controller/book_detials_controller.dart';

class BookDetailsView extends GetView<BookDetailsController> {
  const BookDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.goBack();
        return true;
      },
      child: Scaffold(
        body: Directionality(
          textDirection: TextDirection.ltr,
          child: Obx(
            () => Container(
              width: Get.width,
              color: Color(AppConstants.lightTan),
              child: Stack(
                children: [
                  GestureDetector(
                    onHorizontalDragEnd: (DragEndDetails details) {
                      if (details.primaryVelocity! < 0) {
                        if (!controller.previousFlag.value &&
                            !controller.nextFlag.value) {
                          controller.previousPage();
                        }
                      } else if (details.primaryVelocity! > 0) {
                        if (!controller.previousFlag.value &&
                            !controller.nextFlag.value) {
                          controller.nextPage();
                        }
                      }
                    },
                    child: FlipWidget<int>(
                      flipType: FlipType.middleFlip,
                      itemStream: controller.flipController.stream,
                      itemBuilder: (context, value) {
                        return BookItemBuilder(key: key, value: value);
                      },
                      initialValue: controller.nextFlipValue.value,
                      flipDirection: controller.direction.value,
                      flipCurve: FlipWidget.defaultFlip,
                      flipDuration: const Duration(milliseconds: 500),
                      perspectiveEffect: 0.003,
                      hingeWidth: 0.00,
                      hingeLength: 0.0,
                    ),
                  ),
                  Positioned(
                    top: 30.h,
                    left: 10.w,
                    child: BackButtonPurple(
                      // leave it const value
                      height: 30,
                      width: 36,
                      fromBook: true,
                      onTap: controller.goBack,
                    ),
                  ),
                  Positioned(
                    bottom: 70.h,
                    right: 5.w,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0, right: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          controller.tapMuteSoundButton();
                        },
                        child: SvgPicture.asset(
                          controller.pausedPermanent.value
                              ? AppAssets.kReadWithJeelUnMuteButton
                              : AppAssets.kReadWithJeelMuteButton,
                          fit: BoxFit.fill,
                          height: 50.h,
                          width: 50.w,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 20,
                    left: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const NextPageButton(),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: StreamBuilder(
                              stream: controller.flipController.stream,
                              builder: (context, snapshot) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 8),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Text(
                                        '${LocalKeys.kPages.tr} ${(((snapshot.data ?? 0) as int) + 1)} \\ ${controller.bookPagesNo}',
                                        style: const TextStyle(
                                          height: 1,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Container(
                                          alignment: Alignment.topCenter,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: LinearProgressIndicator(
                                              minHeight: 15,
                                              value: (((snapshot.data ?? 0)
                                                          as int) +
                                                      1) /
                                                  controller.bookPagesNo,
                                              backgroundColor: Colors.grey,
                                              color: const Color(0xff00B848),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                              initialData: 0,
                            ),
                          ),
                        ),
                        const PreviousPageButton(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
