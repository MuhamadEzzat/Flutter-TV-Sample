import 'package:get/get.dart';

import '../controller/book_detials_controller.dart';

class BookDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BookDetailsController());
  }
}
