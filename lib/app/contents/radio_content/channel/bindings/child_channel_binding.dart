import 'package:get/get.dart';
import '../../../../data/providers/josoor_provider.dart';
import '../../../../shared/shared_bar_controller/shared_bar_controller.dart';
import '../controllers/child_channel_new_controller.dart';

class ChildChannelBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ChildChannelNewController());
    Get.lazyPut(() => SharedBarController());
    Get.lazyPut<JosoorProvider>(
          () => JosoorProvider(),
    );
  }
}
