
import 'package:get/get.dart';
import 'package:note/pages/home/home_controller.dart';

import '../tag/tag_controller.dart';

class AllControllerBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<TagController>(() => TagController());
  }
}