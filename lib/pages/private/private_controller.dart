



import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivateController extends GetxController {
  RxList hotList = [].obs;
  // 1
  late WebViewController controller;

  @override
  void onInit() {
    // TODO: implement onInit
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://www.csdn.net/'));

    super.onInit();
  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

}