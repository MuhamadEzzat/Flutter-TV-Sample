import 'package:get/get.dart';

import '../../../shared/shared_bar_controller/shared_bar_controller.dart';
import '../controller/video_cipher_controller.dart';

class VideoCipherBinding extends Bindings {
  @override
  void dependencies() {

    Get.put(SharedBarController());
    Get.put(VideoCipherController());
  }
}
