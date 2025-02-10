

import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:note/pages/tagListView/tag_listView_controller.dart';

//TagPage
class TagListiewBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<TagListviewController>(() => TagListviewController());
  }
}
