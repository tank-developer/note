


import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:dio/dio.dart' as dio_package;
import 'package:note/pages/utils/networkUtil/networkUtil.dart';

import '../AuthService/AuthService.dart';
import '../utils/urls.dart';

class SearchNoteController extends GetxController{

  RxList hotList=[].obs;

  @override
  void onReady() {
    // TODO: implement onReady
    getNoteList();
    super.onReady();
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }


  void getNoteList() async{
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
    dio.options.contentType="multipart/form-data";
    ///请求header的配置
    dio.options.headers["token"]=token;
    final formData = dio_package.FormData.fromMap({
      "searchTerm":"android",
    });
    var response = await dio.post(Urls.url_content_search, data: formData);
    Map<String, dynamic> listJsonMap = Map();
    print(response);
    try {
      listJsonMap = jsonDecode(response.toString());
      var listJsonMap2 = listJsonMap["data"]["list"];
      hotList.value = listJsonMap2;
    }catch (e){
      print("excetpiono"+e.toString());
    }finally{

    }
  }
}