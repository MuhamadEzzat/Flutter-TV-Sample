import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../core/values/app_assets.dart';
import '../../controller/book_detials_controller.dart';

class PreviousPageButton extends GetView<BookDetailsController> {
  const PreviousPageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: GestureDetector(
        onTap: () {
          if (!controller.previousFlag.value && !controller.nextFlag.value) {
            controller.previousPage();
          }
        },
        child: SvgPicture.asset(
          AppAssets.kReadWithJeelPreviousButton,
          width: 40.w,
          height: 40.h,
        ),
      ),
    );
  }
}
