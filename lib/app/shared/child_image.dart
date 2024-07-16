import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/Constants/constants.dart';
import '../core/values/app_assets.dart';
import '../data/models/child_model.dart';

class ChildImage extends StatelessWidget {
  final Child child;
  final int index;
  final double height;
  final double width;

  const ChildImage({
    Key? key,
    required this.child,
    required this.index,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          AppAssets.kChildReportBg,
          semanticsLabel: 'Acme Logo',
          width: height,
          height: width,
          color: index == 0
              ? const Color(0xffB8DFF2)
              : index.isEven
                  ? const Color(0xffe2c3dd)
                  : const Color(0xffd8d8d8),
          fit: BoxFit.cover,
        ),
        SizedBox(
          height: height,
          width: width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
                child.profilePicture ?? AppConstants.errorImage,
                fit: BoxFit.fill),
          ),
        ),
      ],
    );
  }
}
