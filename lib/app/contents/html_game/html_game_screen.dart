import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import '../../core/utils/audio_player_utils.dart';
import '../../core/utils/screen_orientation_util.dart';
import '../../core/values/app_assets.dart';
import '../../shared/scaffold_web_view.dart';

class HTML5GameScreen2 extends StatelessWidget {
  final String gameURL;
  final String gameName;

  const HTML5GameScreen2({
    Key? key,
    required this.gameURL,
    required this.gameName,
  }) : super(key: key);

  initState() {
    ScreenOrientationUtil.landscapeFromPortrait();
  }

  @override
  Widget build(BuildContext context) {
    print("gameName $gameName");
    return Stack(
      children: [
        const ScaffoldWebView(
          url: "https://games.jeelapp.com/concetrate-collect-html5/",
          appBarTitle: '',
          enableJavaScript: true,
          hideAppBar: true,
        ),
        Positioned(
          top: gameName == 'ConcentrateCollect' || gameName == 'Memory'
              ? 65.0
              : 10.0,
          left: gameName == 'ConcentrateCollect' || gameName == 'Memory'
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
                  Navigator.of(context).pop();
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
