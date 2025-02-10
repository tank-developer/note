


import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:note/main.dart';
import 'package:note/pages/utils/networkUtil/networkUtil.dart';

import '../AuthService/AuthService.dart';
import 'package:dio/dio.dart' as dio_package;

import '../utils/urls.dart';

class TagListviewController extends GetxController{

  RxString navTitle = "".obs;
  RxList itemList = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getContentByTagid();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
  void getContentByTagid() async {
    var argument = Get.arguments["map"];
    var argumentId = argument["id"];
    navTitle.value = argument["title"];
    final authService = AuthService();
    String info = await authService.getUserInfo() as String;
    Map<String, dynamic> jsonMap = Map();
    try {
      jsonMap = jsonDecode(info);
      print(jsonMap);
    } catch (e) {
      print("Error: $e");
    }

    var data = jsonMap["data"];
    var token = data["token"];

    // var dio = dio_package.Dio();
    var dio = Networkutil.getDio();
    ///在这里修改 contentType
    dio.options.contentType = 'multipart/form-data';

    ///请求header的配置
    dio.options.headers["token"] = token;
    final formData = dio_package.FormData.fromMap({
      "tagId": argumentId,
    });
    var response = await dio.post(Urls.url_tags_bytagId, data: formData);
    print(response);

    Map JsonMap = jsonDecode(response.toString());
    var code = JsonMap["code"];
    if (code == 200){
      List dataArr = JsonMap["data"];
      print("tags==="+dataArr.toString());
      itemList.value = dataArr;
    }
  }
}