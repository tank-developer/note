
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:note/pages/tag/tag_controller.dart';
//TagPage
class TagBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<TagController>(() => TagController());
  }
}