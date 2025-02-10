

import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:note/pages/utils/networkUtil/networkUtil.dart';

import '../AuthService/AuthService.dart';
import 'package:dio/dio.dart' as dio_package;

import '../utils/urls.dart';

class UserCenterController extends GetxController{

  RxMap userMap = {}.obs;
  RxString userStr = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getUserInfo();
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

  void getUserInfo() async{
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
    });

    var response = await dio.post(Urls.url_user_info, data: formData);
    print(response);
    Map JsonMap = jsonDecode(response.toString());
    Map dataArr = JsonMap["data"];
    Map cellitem = Map();
    cellitem["avatar"] = dataArr["avatar"];
    cellitem["username"] = dataArr["username"];
    if (dataArr["phone"] != null){
      cellitem["phone"] =  dataArr["phone"];
    }
    if (dataArr["email"] != null){
      cellitem["email"] =  dataArr["email"];
    }
    cellitem["logout"] = "退出登录";
    userMap.value = cellitem;
  }
}