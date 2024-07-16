import 'package:get/get.dart';
import '../controllers/html_game_controller.dart';

class HtmlGameBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HtmlGameController());
  }
}
