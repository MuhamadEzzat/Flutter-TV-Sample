import 'package:get/get.dart';
import 'package:multimedia_tv_sample/app/contents/book_content/book_details/binding/book_details_binding.dart';
import 'package:multimedia_tv_sample/app/contents/radio_content/channel/bindings/child_channel_binding.dart';
import 'package:multimedia_tv_sample/app/contents/video_cipher_content/view/video_cipher_view.dart';
import 'package:multimedia_tv_sample/app/home/binding/home_binding.dart';
import 'package:multimedia_tv_sample/app/home/view/home_view.dart';

import '../contents/book_content/book_details/views/book_details_view.dart';
import '../contents/html_game/bindings/html_game_binding.dart';
import '../contents/html_game/views/html5_game_screen.dart';
import '../contents/radio_content/channel/views/child_channel_new_view.dart';
import '../contents/video_cipher_content/binding/video_cipher_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const kINITIAL = Routes.APP_HOME;

  static final routes = [
    GetPage(
      name: _Paths.APP_HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.eduVideoList,
      page: () => const VideoCipherView(),
      binding: VideoCipherBinding(),
    ),
    GetPage(
      name: _Paths.newHtmlGame,
      page: () => const HTML5GameScreen(),
      binding: HtmlGameBinding(),
    ),
    GetPage(
      name: _Paths.bookDetails,
      page: () => const BookDetailsView(),
      binding: BookDetailsBinding(),
    ),
    GetPage(
      name: _Paths.childChannelDetailsNew,
      page: () => const ChildChannelNewView(),
      binding: ChildChannelBinding(),
    ),
  ];
}
