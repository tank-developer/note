
import 'dart:convert';

import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio_package;
import 'package:note/pages/utils/networkUtil/networkUtil.dart';

import '../AuthService/AuthService.dart';
import '../utils/urls.dart';


class HomeDetailController extends GetxController{
  RxList hotList=[].obs;
  // RxMap obsData = Map<String,String>().obs;
  // Map<String, dynamic> obsData = <String, dynamic>{}.obs;
  RxString obsData = ''.obs;
  // Map<String,dynamic> map = <String,dynamic>{}.obs;
  RxString title = ''.obs;
  RxString content = ''.obs;
  // RxList imageUrls = [].obs;
  RxList<String> imageUrls = <String>[].obs;

  RxBool isEdit = false.obs;

  RxString titletext = "".obs;
  RxString contenttext = "".obs;



  void onInit() {
    print("请求接口数据");
    getNote();
    super.onInit();
  }

  @override
  void onClose() {
    print("onClose");
    super.onClose();
  }

  void setTextFieldEditStatus(){
    isEdit.value = !isEdit.value;
    if (isEdit.value == false){
      updateNote();
    }
  }

  void updateNote() async{
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
    var argumentId = Get.arguments['id'];

    final formData = dio_package.FormData.fromMap({
      "contentId":argumentId,
      "content":contenttext,
      "title":titletext,
    });
    try{
      var response = await dio.post(Urls.url_update_note, data: formData);
      print(response.toString());
      Map responseMap = jsonDecode(response.toString());//3
      var code = responseMap["code"];
      if (code == 200){
        getNote();
      }
    }catch(e){
      print("Error: $e");
    }finally{
      // update();
    }
  }

  void getNote() async{
    // url_query_note_id
    // hotList.add("我是一个模拟的数据");
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

    var dio = Networkutil.getDio();
    // var dio = dio_package.Dio();
    ///在这里修改 contentType
    dio.options.contentType="application/json";
    ///请求header的配置
    dio.options.headers["token"]=token;
    var argumentId = Get.arguments['id'];

    final formData = dio_package.FormData.fromMap({
      "contentId":argumentId,
    });
    try{
      var response = await dio.post(Urls.url_query_note_id, data: formData);
      print(response.toString());
      Map responseMap = jsonDecode(response.toString());//3
      var code = responseMap["code"];
      print("code==="+code.toString());

      if (code == 200){
        print(responseMap.toString());
        obsData.value = responseMap["data"].toString();
        title.value = responseMap["data"]["title"];
        content.value = responseMap["data"]["content"];
        var responsImage = responseMap["data"]["image"].toString();
        var imageList = responsImage.split(",");
        imageUrls.value = RxList.from(imageList); // 使用 RxList.from 转换
      }
    }catch(e){
      print("Error: $e");
    }finally{
      update();

    }
  }

}