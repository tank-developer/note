import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio_package;
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:note/pages/utils/networkUtil/networkUtil.dart';
import 'package:path/path.dart';
import '../AuthService/AuthService.dart';
import '../utils/urls.dart';

class HomeController extends GetxController{
  RxList hotList=[].obs;
  RxString dateObs=''.obs;
  RxMap userMap= {}.obs;

  void deleteItem(int index) {
    // hotList.removeAt(index);
    var item = hotList[index];
    var itemId = item["id"].toString();
    deleteHotList(itemId);
  }
  void deleteHotList(String itemId) async{
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
      "contentId":itemId,
    });
    var response = await dio.post(Urls.url_delete_note, data: formData);
    print(response);
    Map listJsonMap = jsonDecode(response.toString());
    print("image_delete2"+listJsonMap.toString());

  }

  void deleteImages(List<String> fileUrls) async{
    List<String> imageName = [];
    for(var i = 0;i < fileUrls.length;i++){
      print(fileUrls[i]);
      var fileUrl = fileUrls[i].toString();
      var urlItem = fileUrl.split("/");
      var lastObject = urlItem.last.toString();

      imageName.add(lastObject);
    }
    // 设置请求头（可选）
    Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
    };
    print("imageName"+imageName.toString());

    // var dio = dio_package.Dio();
    var dio = Networkutil.getDio();
    var imageResponse = await dio.post(Urls.url_delete_image, data: imageName,options: Options(headers: headers));
    print("image_delete"+imageResponse.toString());

  }
  void getUserInfoMap(AuthService authService) async{
    String userInfo = await authService.getUserInfo();
    Map<String, dynamic> userInfoMap = Map();
    try {
      userInfoMap = jsonDecode(userInfo);
      print(userInfoMap);
    } catch (e) {
      print("Error: $e");
    }
    print("userMap.value"+userMap.value.toString());
    String yourToken = "Your JWT";
    Map<String, dynamic> decodedToken = JwtDecoder.decode(userInfoMap["data"]["token"]);
    print("decodedToken"+decodedToken.toString());
    userMap.value = decodedToken;
  }
  void onInit() async{
    print("请求接口数据");
    final authService = AuthService();

    getUserInfoMap(authService);


    String dateStore = await authService.getDate();
    if (dateStore.length != 0){
      DateTime date = DateTime.parse(dateStore);
      getHotList(date.toString());
      dateObs.value = dateStore.toString();
    }else{
      var current = DateTime.now();
      int currentYear = current.year;
      int currentMonth = current.month;
      int currentDay = current.day;
      String timeFormat = currentYear.toString() + "-" + currentMonth.toString() + "-" + currentDay.toString();
      DateTime date1 = DateTime.parse(timeFormat);
      authService.saveDate(timeFormat);
      getHotList(date1.toString());
      dateObs.value = timeFormat.toString();
    }

    super.onInit();
  }

  @override
  void onClose() {
    print("onClose");
    super.onClose();
  }

  void getHotList(String currentDate) async{
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
    final formData = dio_package.FormData.fromMap({
      "pageNum":1,
      "pageSize":19,
      "updatedAt":currentDate
    });
    var response = await dio.post(Urls.url_content_list_updateAt, data: formData);
    // print(response.toString());

    Map<String, dynamic> listJsonMap = Map();
    try {
      listJsonMap = jsonDecode(response.toString());
      var listJsonMap2 = listJsonMap["data"]["list"];
      for(var i = 0;i < listJsonMap2.length;i++){
        print(listJsonMap2[i]);
        var noteMap1 = listJsonMap2[i];

        Map<String, dynamic> noteMap = Map();
        noteMap["title"] = noteMap1["title"];
        noteMap["content"] = noteMap1["content"];
        noteMap["image"] = noteMap1["image"];
        noteMap["userId"] = noteMap1["userId"];
        String updatedAt = parseAndFormatDate(noteMap1["updatedAt"].toString());
        String createdAt = parseAndFormatDate(noteMap1["createdAt"].toString());

        noteMap["updateAt"] = updatedAt;
        noteMap["createAt"] = createdAt;
        noteMap["id"] = noteMap1["id"];

        hotList.add(noteMap);
      }
    } catch (e) {
      print("Error: $e");
    }
    update();
  }



  Future<void> selectDate(BuildContext context) async {
    final authService = AuthService();
    String dateStore = await authService.getDate();
    // authService.saveDate(date)
    if (dateStore == ""){
      var current = DateTime.now();
      int currentYear = current.year;
      int currentMonth = current.month;
      int currentDay = current.day;
      // String timeFormat = currentYear.toString() + "-" + currentMonth.toString() + "-" + currentDay.toString();
      String timeFormat = current.toIso8601String().split('T')[0]; // 只取日期部分

      DateTime date1 = DateTime.parse(timeFormat);
      authService.saveDate(date1.toString());
      dateStore = timeFormat;
    }
    DateTime date = DateTime.parse(dateStore);

    final DateTime? picked = await showDatePicker(
      context: context, // 上下文
      initialDate: date, // 初始化选中日期
      firstDate: DateTime(2023, 5), // 开始日期
      lastDate: DateTime(2025, 12), // 结束日期
      currentDate: DateTime.now(), // 当前日期
      initialEntryMode: DatePickerEntryMode.calendar, // 日历弹框样式
      selectableDayPredicate: (dayTime) {
        // 自定义哪些日期可选
        if (dayTime == DateTime(2022, 5, 6) ||
            dayTime == DateTime(2022, 6, 8)) {
          return false;
        }
        return true;
      },
      helpText: "请选择日期", // 左上角提示文字
      cancelText: "Cancel", // 取消按钮 文案
      confirmText: "OK", // 确认按钮 文案
      initialDatePickerMode: DatePickerMode.day, // 日期选择模式 默认为天
      useRootNavigator: true, // 是否使用根导航器
      errorFormatText: "输入日期格式有误，请重新输入", // 输入日期 格式错误提示
      errorInvalidText: "输入日期不合法，请重新输入", // 输入日期 不在first 与 last 之间提示
      fieldLabelText: "输入所选日期", // 输入框上方 提示
      fieldHintText: "请输入日期", // 输入框为空时提示
      // textDirection: TextDirection.ltr, // 水平方向 显示方向 默认 ltr
      // 时间选择模式
      onDatePickerModeChange: (mode) {
        print("DatePicker mode changed to: $mode");
      },
    );

    if (picked != null) {
      String dateSelected = parseAndFormatDate(picked.toString());
      final authService = AuthService();
      authService.saveDate(dateSelected);
      hotList.clear();
      getHotList(picked.toString());
      dateObs.value = dateSelected;
      // print(picked);
    }
  }

String parseAndFormatDate(String originalDateString) {
  DateTime? parsedDate;
  String formattedDate = "";
  try {
    // 解析 ISO 8601 格式的日期字符串
    parsedDate = DateTime.parse(originalDateString);

    // 格式化日期为 "yyyy-MM-dd" 格式
    formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate!);

    // 打印解析后的日期
    print("Parsed Date: $parsedDate");
    print("Formatted Date: $formattedDate");
    return formattedDate;
  } catch (e) {
    print("Error parsing date: $e");
  }
  return "";
}

}