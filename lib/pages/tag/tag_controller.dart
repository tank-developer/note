
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:dio/dio.dart' as dio_package;
import 'package:note/pages/utils/networkUtil/networkUtil.dart';

import '../AuthService/AuthService.dart';
import '../utils/color/extension_color.dart';
import '../utils/urls.dart';

class TagController extends GetxController{

  // RxList<String> icons = ["","","","","",""].obs;
  RxList<Map>  categories = <Map>[].obs;

  // RxList<Map>  categories = [
  // {
  // 'title': 'App 排行',
  // 'gradient': LinearGradient(
  //   begin: Alignment.topCenter,
  //   end: Alignment.bottomCenter,
  //   colors: [Color(0xFF94377F), Color(0xFFF79283)],
  // ),
  // 'icon': Icons.star,
  // },
  // {
  // 'title': '游戏排行',
  // 'gradient': LinearGradient(
  //   begin: Alignment.topCenter,
  //   end: Alignment.bottomCenter,
  //   colors: [Colors.orange, Colors.red],
  // ),
  // 'icon': Icons.star,
  // },
  // // ... 其他类别
  // ].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getTagsList();
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


  void getTagsList() async{
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
    dio.options.contentType="application/json";
    ///请求header的配置
    dio.options.headers["token"]=token;
    final formData = dio_package.FormData.fromMap({
    });
    var response = await dio.post(Urls.url_tags, data: formData);
    print(response);
    Map JsonMap = jsonDecode(response.toString());
    List dataArr = JsonMap["data"];
    print("tags==="+dataArr.toString());

    for (int i = 0;i < dataArr.length;i++){
      var mapData = dataArr[i];
      String tagName = mapData["name"].toString();
      String tagId = mapData["id"].toString();
      Map item = Map();
      item["title"] =tagName;
      item["gradient"] = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [ExtensionColor.noteBackgroundColor1.toColor(), ExtensionColor.noteBackgroundColor2.toColor(),ExtensionColor.noteBackgroundColor3.toColor()],
      );
      item["icon"] = Icons.star;
      item["id"] = tagId;
      categories.add(item);
    }
    update();
  }

  Map getCategoriesId(int index){
    Map map = categories[index];
    // var idStr = map["id"];
    return map;
  }

  void getContentByTagid(int index) async{
    Map map = categories[index];
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
    dio.options.contentType='multipart/form-data';
    ///请求header的配置
    dio.options.headers["token"]=token;
    final formData = dio_package.FormData.fromMap({
      "tagId":map["id"],
    });
    var response = await dio.post(Urls.url_tags_bytagId, data: formData);
    print(response);

  }

}
extension on String {
  toColor() {
    final hexCode = replaceFirst('#', '');
    final alphaChannel = hexCode.length == 8 ? hexCode.substring(0, 2) : 'FF';
    final rgbChannel = hexCode.length == 8 ? hexCode.substring(2) : hexCode;
    return Color(int.parse('$alphaChannel$rgbChannel', radix: 16));
  }
}