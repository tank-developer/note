import 'dart:convert';
import 'dart:io';

import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio_package;
import 'package:get_storage/get_storage.dart';
import 'package:note/pages/tabs.dart';
import 'package:note/pages/utils/loading/juhua_loading.dart';

import '../AuthService/AuthService.dart';
import '../utils/color/extension_color.dart';
import '../utils/networkUtil/networkUtil.dart';
import '../utils/urls.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final identifierController = TextEditingController();
  final passwordController = TextEditingController();
  final isPasswordVisible = false.obs;

  String? validateIdentifier(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入邮箱、手机号或用户名';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入密码';
    }
    if (value.length < 6) {
      return '密码长度至少为6位';
    }
    return null;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void login() async{
    // Loading.showLoading(context)
    if (formKey.currentState!.validate()) {
      // TODO: 实现登录逻辑
      //loooo/12345678
      // var dio = dio_package.Dio();
      var dio = Networkutil.getDio();
      // var url = "http://localhost:80/user/login";
      var url = Urls.url_login;
      var json = {
        "username":identifierController.text,
        "password":passwordController.text,
      };

      var response = await dio.post(url, data: json);
      print(response);
      Map response1Map = jsonDecode(response.toString());//3
      var code = response1Map["status"];

      if (code == 200){
        Get.snackbar('登录', '登录成功');
        var data= jsonDecode(response.toString()).toString();//3
        final authService = AuthService();
        authService.login();
        authService.saveUserInfo(response.toString());
        Get.offAllNamed("/shop");
        // Get.offAll(Tabs());
      }else{
        print(response1Map.toString());
        var message = response1Map["message"];
        Get.snackbar('登录失败', message);
      }
    }
  }

  void goToRegister() {
    // TODO: 实现跳转到注册页面的逻辑
    // Get.snackbar('注册', '跳转到注册页面');
    Get.toNamed("/register",arguments: {
      "id":3456
    });
  }
}

class LoginPage extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 48),
                  Text(
                    '欢迎回来',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: ExtensionColor.btnColor.toColor(),
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  TextFormField(
                    controller: controller.identifierController,
                    decoration: InputDecoration(
                      labelText: '请输入用户名',
                      prefixIcon: Icon(Icons.person,color: ExtensionColor.btnColor.toColor(),),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: controller.validateIdentifier,
                  ),
                  const SizedBox(height: 24),
                  Obx(
                    () => TextFormField(
                      controller: controller.passwordController,
                      obscureText: !controller.isPasswordVisible.value,
                      decoration: InputDecoration(
                        labelText: '密码',
                        prefixIcon: Icon(Icons.lock,color: ExtensionColor.btnColor.toColor(),),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordVisible.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: controller.validatePassword,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: controller.login,
                    child: Text('登录',style: TextStyle(
                      color: ExtensionColor.btnColor.toColor(),           // 文本颜色
                      fontSize: 15,                 // 字体大小
                      fontWeight: FontWeight.bold,  // 字体粗细
                      fontStyle: FontStyle.normal,  // 字体风格
                    ),),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: controller.goToRegister,
                    child: Text('还没有账号？立即注册',style: TextStyle(
                      color: ExtensionColor.btnColor.toColor(),           // 文本颜色
                      fontSize: 15,                 // 字体大小
                      fontWeight: FontWeight.bold,  // 字体粗细
                      fontStyle: FontStyle.normal,  // 字体风格
                    ),),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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