
import 'package:get/get.dart';

import 'home_detail_controller.dart';


class HomeDetailControllerBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<HomeDetailController>(() => HomeDetailController());
  }
}