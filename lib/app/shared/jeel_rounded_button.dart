import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:multimedia_tv_sample/app/core/utils/sizing_extension.dart';

import '../core/values/app_colors.dart';

class JeelRoundedButton extends StatelessWidget {
  final String text;
  final Function? onTap;
  final double? width;
  final double? height, raduis;
  final double? fontSize;
  final bool enabled;
  final Color? color, borderColor;
  final Widget? widget;
  const JeelRoundedButton(
      {Key? key,
      required this.text,
      required this.onTap,
      this.width,
      this.height,
      this.raduis,
      this.borderColor,
      this.enabled = true,
      this.color,
      this.widget,
      this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: () {
        if (enabled && onTap != null) onTap!();
      },
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 48.hp(context),
        padding: EdgeInsets.fromLTRB(
          2.wp(context),
          8.hp(context),
          2.wp(context),
          4.hp(context),
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              raduis ?? 40.hp(context),
            ),
          ),
          border: Border.all(
            color: !enabled
                ? AppColors.lightGray
                : borderColor ?? AppColors.newPurple,
          ),
          color: enabled ? color ?? AppColors.newPurple : AppColors.lightGray,
        ),
        child: widget ??
            AutoSizeText(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: color == null ? Colors.white : AppColors.newPurple,
                fontSize: fontSize ?? 12.sp(context),
                height: 1.1,
              ),
            ),
      ),
    );
  }
}
