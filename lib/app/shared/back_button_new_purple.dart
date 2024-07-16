import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../core/values/app_assets.dart';


class BackButtonPurple extends StatelessWidget {
  final double height;
  final double width;
  final Function onTap;
  final bool fromBook;

  /// set value to false in case not from book view details

  const BackButtonPurple({
    Key? key,
    required this.height,
    required this.width,
    required this.onTap,
    required this.fromBook,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isAr = Get.locale?.languageCode == "ar";
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
                isAr || fromBook
                    ? AppAssets.kLeftSquareArrow
                    : AppAssets.kRightSquareArrow,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
