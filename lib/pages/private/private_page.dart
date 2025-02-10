



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note/pages/utils/language/language.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'private_controller.dart';

class PrivatePage extends GetView<PrivateController> {
  PrivatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(Globalization.private.tr),
        ),
      body: Obx((){
        return Column(
          children: [
            Expanded(child: WebViewWidget(controller: controller.controller)),
            Text(controller.hotList.string)
          ],
        );
      })
    );
  }
}