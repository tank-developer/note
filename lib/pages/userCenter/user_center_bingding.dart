
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:note/pages/userCenter/user_center_controller.dart';

class UserCenterBingding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<UserCenterController>(() => UserCenterController());
  }
}