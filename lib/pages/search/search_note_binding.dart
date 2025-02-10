
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:note/pages/search/search_controller.dart';

class SearchNoteBinding implements Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SearchNoteController>(() => SearchNoteController());
  }
}
