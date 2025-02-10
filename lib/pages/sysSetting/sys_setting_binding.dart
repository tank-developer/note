

import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:note/pages/sysSetting/sys_setting_controller.dart';

class SysSettingBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SysSettingController>(() => SysSettingController());
  }
}
