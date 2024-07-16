import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../../../core/values/app_assets.dart';
import '../../../shared/scaffold_web_view.dart';
import '../controllers/html_game_controller.dart';

class HTML5GameScreen extends GetView<HtmlGameController> {
  const HTML5GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ScaffoldWebView(
          url: controller.gameURL ?? "",
          appBarTitle: '',
          enableJavaScript: true,
          hideAppBar: true,
        ),
        Positioned(
          top: controller.gameName == 'ConcentrateCollect' ||
                  controller.gameName == 'Memory'
              ? 65.0
              : 10.0,
          left: controller.gameName == 'ConcentrateCollect' ||
                  controller.gameName == 'Memory'
              ? 5.0
              : 10.0,
          child: Transform(
            transform: Matrix4.translationValues(
              0.0,
              0,
              0.0,
            ),
            child: PointerInterceptor(
              child: GestureDetector(
                onTap: () {
                  controller.goBack();
                },
                child: Image.asset(
                  AppAssets.kBackButton,
                  height: 70,
                  width: 70,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
