


//提交数据,提交无标签的
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as DioMultipartFile show MultipartFile;
import 'package:dio/dio.dart' as DioFormData show FormData;
import 'package:dio/dio.dart' as DioDio show Dio;
import 'package:dio/dio.dart' as DioOptions show Options;


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note/pages/utils/loading/juhua_loading.dart';
import 'package:note/pages/utils/networkUtil/networkUtil.dart';

import '../../AuthService/AuthService.dart';
import '../../utils/urls.dart';

Future<void> submitData (List<File> imageList,BuildContext context,TextEditingController contentController,TextEditingController titleController) async {
  if (imageList.isEmpty) {
    Get.snackbar("图片", "请选择图片");
    return;
  }
  Loading.showLoading(context);
  try {
    List<DioMultipartFile.MultipartFile> multipartFiles = await Future.wait(
      imageList.map((image) async {
        File file = File(image.path);
        return await DioMultipartFile.MultipartFile.fromFile(file.path, filename: file.path
            .split('/')
            .last);
      }).toList(),
    );

    var formData = DioFormData.FormData.fromMap({
      'files': multipartFiles,
    });

    // DioDio.Dio dio = DioDio.Dio();
    DioDio.Dio dio = Networkutil.getDio();
    var response = await dio.post(
      Urls.url_upload_images,
      data: formData,
      options: DioOptions.Options(headers: {
        'Content-Type': 'multipart/form-data',
      }),
    );
    Map responseMap = jsonDecode(response.toString());//3
    var code1 = responseMap["code"];

    if (code1 == 200) {
      var imageUrls = responseMap["data"];
      // ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('上传成功')));
      print('Image URLs: $imageUrls');
      print(imageUrls.join(","));
      var urlStr = imageUrls.join(",");
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

      var formData = DioFormData.FormData.fromMap({
        "content":contentController.text,
        "title":titleController.text,
        "imageurl":urlStr,
      });

      ///在这里修改 contentType
      dio.options.contentType="multipart/form-data";
      ///请求header的配置
      dio.options.headers["token"]=token;
      var response1 = await dio.post(
        Urls.url_upload_note,
        data: formData,
      );
      Map response1Map = jsonDecode(response1.toString());//3
      var code1 = response1Map["code"];
      if (code1 == 200) {
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('上传成功')));
        Get.snackbar("成功", "上传成功");
        Loading.hideLoading(context);
        return;
      }else{
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('上传失败')));
        Get.snackbar("失败", "上传失败");
        Loading.hideLoading(context);
      }
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('上传失败')));
      Get.snackbar("失败", "上传失败");
      Loading.hideLoading(context);
    }
  } catch (e) {
    Get.snackbar("失败", "上传失败");
  }
  // var res = await Dio().post("你的URL", data: formData);
  //后面随意发挥
}

Future<void> submitDataAndTag (List<File> imageList,BuildContext context,TextEditingController contentController,TextEditingController titleController,String tagStr) async {
  if (imageList.isEmpty) {
    Get.snackbar("图片", "请选择图片");
    return;
  }
  Loading.showLoading(context);
  try {
    List<DioMultipartFile.MultipartFile> multipartFiles = await Future.wait(
      imageList.map((image) async {
        File file = File(image.path);
        return await DioMultipartFile.MultipartFile.fromFile(file.path, filename: file.path
            .split('/')
            .last);
      }).toList(),
    );

    var formData = DioFormData.FormData.fromMap({
      'files': multipartFiles,
    });

    // DioDio.Dio dio = DioDio.Dio();
    DioDio.Dio dio = Networkutil.getDio();
    var response = await dio.post(
      Urls.url_upload_images,
      data: formData,
      options: DioOptions.Options(headers: {
        'Content-Type': 'multipart/form-data',
      }),
    );
    Map responseMap = jsonDecode(response.toString());//3
    var code1 = responseMap["code"];

    if (code1 == 200) {
      var imageUrls = responseMap["data"];
      // ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('上传成功')));

      print('Image URLs: $imageUrls');
      print(imageUrls.join(","));

      var urlStr = imageUrls.join(",");
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

      var formData = DioFormData.FormData.fromMap({
        "content":contentController.text,
        "title":titleController.text,
        "imageurl":urlStr,
        "tagName":tagStr,
      });
      print("tag:"+tagStr);

      ///在这里修改 contentType
      dio.options.contentType="multipart/form-data";
      ///请求header的配置
      dio.options.headers["token"]=token;
      var response1 = await dio.post(
        Urls.url_upload_note_tag,
        data: formData,
      );
      Map response1Map = jsonDecode(response1.toString());//3
      var code1 = response1Map["code"];
      if (code1 == 200) {
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('上传成功')));
        Get.snackbar("成功", "上传成功");
        Loading.hideLoading(context);
        return;
      }else{
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('上传失败')));
        Get.snackbar("失败", "上传失败");
        Loading.hideLoading(context);
      }
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('上传失败')));
      Get.snackbar("失败", "上传失败");
      Loading.hideLoading(context);
    }
  } catch (e) {
    // ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('上传失败: $e')));
    Get.snackbar("失败", "上传失败");

  }
  // var res = await Dio().post("你的URL", data: formData);
  //后面随意发挥
}

