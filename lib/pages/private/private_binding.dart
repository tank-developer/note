


import 'package:get/get.dart';

import 'private_controller.dart';

class PrivateBinding implements Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<PrivateController>(() => PrivateController());
  }
}
