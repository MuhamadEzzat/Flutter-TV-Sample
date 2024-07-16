import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:universal_platform/universal_platform.dart';

import '../core/values/app_assets.dart';
import '../core/values/app_colors.dart';
import '../core/values/app_styles.dart';


class JeelAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Function? onBack;
  final bool enableBackIcon;
  final bool showHelpIcon;
  final Widget? leftWidget;
  final Color backgroundColor;
  final Color? iconThemeDataColor;
  final bool? centerTitle;

  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));

  const JeelAppBar({
    Key? key,
    required this.title,
    this.onBack,
    this.leftWidget,
    this.bottom,
    this.enableBackIcon = true,
    this.actions,
    this.showHelpIcon = false,
    this.iconThemeDataColor = AppColors.white,
    this.backgroundColor = Colors.white,
    this.centerTitle = true,
  }) : super(key: key);

  @override
  _JeelAppBarState createState() => _JeelAppBarState();
}

class _JeelAppBarState extends State<JeelAppBar> {
  bool isLoadingHelp = false;
  late bool canPop;

  @override
  void initState() {
    super.initState();
    canPop = Get.key.currentState!.canPop();
  }

  @override
  Widget build(BuildContext context) {
    bool isAr = Get.locale?.languageCode == "ar";
    return Directionality(
      textDirection: isAr ? TextDirection.ltr : TextDirection.rtl,
      child: AppBar(
        actionsIconTheme: IconThemeData(color: widget.iconThemeDataColor),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        bottom: widget.bottom,
        elevation: 0.5,
        iconTheme: IconThemeData(color: widget.iconThemeDataColor),
        actions: <Widget>[
          if (widget.actions != null) ...widget.actions!,
          if (widget.enableBackIcon && canPop)
            IconButton(
              icon: Icon(
                isAr ? FontAwesomeIcons.arrowRight : FontAwesomeIcons.arrowLeft,
                color: widget.backgroundColor == Colors.white
                    ? Colors.black
                    : widget.iconThemeDataColor,
                size: 19.sp,
              ),
              onPressed: () {
                if (widget.onBack != null) {
                  widget.onBack!();
                } else {
                  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                      overlays: []);
                  Get.back();
                }
              },
            ),
        ],
        centerTitle: widget.centerTitle,
        backgroundColor: widget.backgroundColor,
        title: UniversalPlatform.isWeb
            ? SizedBox(
                width: Get.width,
                height: Get.height * 0.065,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    UniversalPlatform.isWeb
                        ? const SizedBox.shrink()
                        : Positioned(
                            top: 0,
                            bottom: 0,
                            right: 0,
                            left: 600.w,
                            child: Image.asset(
                              AppAssets.kLogoGif,
                              width: 55.0,
                              height: 55.0,
                            ),
                          ),
                    AutoSizeText(
                      widget.title,
                      minFontSize: 8,
                      maxLines: 1,
                      style: AppTextStyles.childTextStyle.copyWith(
                          height: .8, color: widget.iconThemeDataColor),
                    ),
                  ],
                ),
              )
            : AutoSizeText(
                widget.title,
                minFontSize: 8,
                maxLines: 1,
                style: AppTextStyles.childTextStyle.copyWith(
                  height: .8,
                  color: widget.backgroundColor == Colors.white
                      ? Colors.black
                      : widget.iconThemeDataColor,
                ),
              ),
        // title: Directionality(
        //   textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
        //   child: AutoSizeText(
        //     widget.title,
        //     minFontSize: 8,
        //     maxLines: 1,
        //     style: AppTextStyles.childTextStyle.copyWith(
        //       height: .8,
        //       color: widget.backgroundColor == Colors.white
        //           ? Colors.black
        //           : widget.iconThemeDataColor,
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
