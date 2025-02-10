
import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:note/pages/utils/networkUtil/networkUtil.dart';

import '../AuthService/AuthService.dart';
import '../utils/urls.dart';
import 'package:dio/dio.dart' as dio_package;

class SysSettingController extends GetxController{

    @override
    void onReady() {
      // TODO: implement onReady
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

    void dismissAccount() async{
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
      dio.options.headers["token"]=token;
      final formData = dio_package.FormData.fromMap({
      });

      var response = await dio.post(Urls.url_user_dismiss, data: formData);
      print(response);
      Map response1Map = jsonDecode(response.toString());//3
      var code1 = response1Map["code"];
      if (code1 == 200){
        Get.snackbar('warnning', '注销成功');
      }
      // Map JsonMap = jsonDecode(response.toString());
      // Map dataArr = JsonMap["data"];

    }

}