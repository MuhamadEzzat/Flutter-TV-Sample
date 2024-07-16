import 'dart:async';
import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/core/Constants/constants.dart';
import 'app/core/utils/shared_prefs_utils.dart';
import 'app/core/values/app_colors.dart';
import 'app/core/values/localization/messages.dart';
import 'app/routes/app_pages.dart';
import 'app_navigation_observer.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget with WidgetsBindingObserver {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {

  StreamSubscription<Map>? branchStreamSubscription;

  //CleverTapPlugin _clevertapPlugin = CleverTapPlugin();
  var inboxInitialized = false;
  var optOut = false;
  var enableDeviceNetworkingInfo = false;


  @override
  void initState() {
    super.initState();
    // Get.lazyPut(() => RegisterAddExtraInfoController());
    // Get.put(SharedBarController());
    initPrefs();
  }

  @override
  void dispose() {
    branchStreamSubscription?.cancel();
    super.dispose();
  }


  SharedPreferences? sharedPrefs;

  void initPrefs() async {
    await SharedPrefsUtil.init();
    sharedPrefs = SharedPrefsUtil.instance;
    sharedPrefs?.get(AppConstants.kLocaleKey);
    if (sharedPrefs?.get(AppConstants.kLocaleKey) != null) {
      Get.updateLocale(Locale("${sharedPrefs?.get(AppConstants.kLocaleKey)}"));
    }
    debugPrint(
        "Saved Local ${sharedPrefs?.get(AppConstants.kLocaleKey) ?? "Saved Local Nullll"}");
  }

  final botToastBuilder = BotToastInit(); //1. call BotToastInit

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return Shortcuts(
            shortcuts:  <LogicalKeySet, Intent>{
              LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
            },
            child: GetMaterialApp(
              useInheritedMediaQuery: true,
              scrollBehavior: const MaterialScrollBehavior().copyWith(
                dragDevices: {
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.touch,
                  PointerDeviceKind.stylus,
                  PointerDeviceKind.unknown
                },
              ),
              title: 'JeeL',
              // navigatorObservers: [
              //   AppNavigatorObserver(),
              //   MyApp.observer,
              //   BotToastNavigatorObserver(),
              // ],
              initialRoute: AppPages.kINITIAL,
              getPages: AppPages.routes,
              navigatorKey: Get.key,
              // TODO change to ar and delete all directionality and align change directions.ectios
              locale: sharedPrefs?.get(AppConstants.kLocaleKey) != null
                  ? Locale("${sharedPrefs?.get(AppConstants.kLocaleKey)}")
                  : const Locale("ar"),
              translations: Messages(),
              fallbackLocale: Messages.fallbackLocale,
              supportedLocales: Messages.supportedLocales,
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              debugShowCheckedModeBanner: false,
              builder: (context, child) {
                child = MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: const TextScaler.linear(1.0)),
                  child: child ?? const SizedBox.shrink(),
                );
                child = botToastBuilder(context, child);
                return child;
              },
              theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                fontFamily: "PingAR",
                hintColor: Colors.white,
                textSelectionTheme: const TextSelectionThemeData(
                  cursorColor: AppColors.newPurple,
                  selectionHandleColor: AppColors.newPurple,
                ),
                indicatorColor: Colors.deepPurple,
                buttonTheme:
                const ButtonThemeData(buttonColor: AppColors.newPurple),
                // primaryColorBrightness: Brightness.dark,
                primarySwatch: const MaterialColor(
                  0xFFffad4d,
                  <int, Color>{
                    50: Color(0xFFfff7ed),
                    100: Color(0xFFffefdb),
                    200: Color(0xFFffe6ca),
                    300: Color(0xFFffdeb8),
                    400: Color(0xFFffd6a6),
                    500: Color(0xFFffce94),
                    600: Color(0xFFffc682),
                    700: Color(0xff88115F),
                    800: Color(0xFFffb55f),
                    900: Color(0xFFffad4d),
                  },
                ),
              ),
            ),
          );
        });
  }
}
