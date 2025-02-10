import 'dart:convert';

import 'package:dio/dio.dart' as dio_package;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note/main.dart';
import 'package:note/pages/utils/networkUtil/networkUtil.dart';

import '../utils/color/extension_color.dart';
import '../utils/urls.dart';
// import 'package:get/get.dart';

class EnhancedRegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final verificationCodeController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isEmailMode = true.obs;
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  final isSendingCode = false.obs;
  final countdown = 60.obs;

  void toggleRegisterMode() {
    isEmailMode.value = !isEmailMode.value;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入用户名';
    }
    if (value.length < 3) {
      return '用户名至少需要3个字符';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入邮箱';
    }
    if (!GetUtils.isEmail(value)) {
      return '请输入有效的邮箱地址';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入手机号';
    }
    if (!GetUtils.isPhoneNumber(value)) {
      return '请输入有效的手机号';
    }
    return null;
  }

  String? validateVerificationCode(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入验证码';
    }
    if (value.length != 6) {
      return '验证码应为6位数字';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入密码';
    }
    if (value.length < 8) {
      return '密码长度至少为8位';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return '请确认密码';
    }
    if (value != passwordController.text) {
      return '两次输入的密码不一致';
    }
    return null;
  }

  void sendVerificationCode() async{
    if ((isEmailMode.value && validateEmail(emailController.text) == null) ||
        (!isEmailMode.value && validatePhone(phoneController.text) == null)) {
      isSendingCode.value = true;
      if (!emailController.text.isEmpty || emailController.text.length != 0){
        // TODO: 实现发送验证码的逻辑
        Get.snackbar('发送验证码', '验证码已发送');
        startCountdown();
        print(usernameController.text);
        print(phoneController.text);
        print(emailController.text);

        // var dio = dio_package.Dio();
        var dio = Networkutil.getDio();
        var url = Urls.url_email_code;


        final formData = dio_package.FormData.fromMap({
          "username":usernameController.text,
          "email":emailController.text,
        });

        var response = await dio.post(url, data: formData);
        print(response);

        //转化为Json
        // String jsonString = jsonEncode(response.data);
        // print(jsonString);
        // // 解析JSON字符串
        // Map<String, dynamic> json = jsonDecode(jsonString);
      }

      if (!phoneController.text.isEmpty || phoneController.text.length != 0){
        // TODO: 实现发送验证码的逻辑
        // Get.snackbar('发送验证码', '验证码已发送');
        startCountdown();
        print(usernameController.text);
        print(phoneController.text);
        print(emailController.text);

        // var dio = dio_package.Dio();
        var dio = Networkutil.getDio();
        dio.options.contentType="application/json";

        var url = Urls.url_phone_code;

        var jsonData = {
          "username":usernameController.text,
          "phone":phoneController.text,
        };
        var response = await dio.post(url, data: jsonData);
        print(response);
        Map<String, dynamic> responseMap = jsonDecode(response.toString());
        var status = responseMap["status"];
        if (status == 200){
          Get.snackbar("验证码","手机验证码发送成功");
        }else{
          Get.snackbar('错误', '请输入有效的手机号');
        }
      }
    } else {
      Get.snackbar('错误', '请输入有效的邮箱或手机号');
    }
  }

  void startCountdown() {
    countdown.value = 60;
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
      countdown.value--;
      return countdown.value > 0;
    }).then((_) => isSendingCode.value = false);
  }

  void register() async {
    if (!phoneController.text.isEmpty || phoneController.text.length != 0) {
      if (formKey.currentState!.validate()) {
        // TODO: 实现注册逻辑
        // var dio = dio_package.Dio();
        var dio = Networkutil.getDio();
        var url = Urls.url_phone_register;
        final formData = dio_package.FormData.fromMap({
          "username": usernameController.text,
          "phone": phoneController.text,
          "password": passwordController.text,
          "code": verificationCodeController.text
        });

        var response = await dio.post(url, data: formData);
        Map<String, dynamic> responseMap = jsonDecode(response.toString());
        var status = responseMap["status"];
        if (status == 200) {
          Get.snackbar("注册", "手机号注册成功");
        } else {
          Get.snackbar('错误', '请重新注册');
        }
      } else {
        if (!emailController.text.isEmpty || emailController.text.length != 0) {
          if (formKey.currentState!.validate()) {
            // TODO: 实现注册逻辑
            // var dio = dio_package.Dio();
            var dio = Networkutil.getDio();
            var url = Urls.url_email_register;
            final formData = dio_package.FormData.fromMap({
              "username": usernameController.text,
              "email": emailController.text,
              "password": passwordController.text,
              "code": verificationCodeController.text
            });

            var response = await dio.post(url, data: formData);
            Map<String, dynamic> responseMap = jsonDecode(response.toString());
            var status = responseMap["status"];
            if (status == 200) {
              Get.snackbar("注册", "邮件注册成功");
            } else {
              Get.snackbar('错误', '请重新注册');
            }
          }
        }
      }
    }
  }
}

class EnhancedRegisterPage extends StatelessWidget {
  final EnhancedRegisterController controller = Get.put(EnhancedRegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('注册'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '创建新账户',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: ExtensionColor.btnColor.toColor(),
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    controller: controller.usernameController,
                    decoration: InputDecoration(
                      labelText: '用户名',
                      prefixIcon: Icon(Icons.person,color: ExtensionColor.btnColor.toColor(),),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: controller.validateUsername,
                  ),
                  SizedBox(height: 16),
                  Obx(() => SegmentedButton<bool>(
                    segments: [
                      ButtonSegment(value: true, label: Text('邮箱注册',style: TextStyle(
                        color: ExtensionColor.btnColor.toColor(),           // 文本颜色
                        fontSize: 14,                 // 字体大小
                        fontWeight: FontWeight.bold,  // 字体粗细
                        fontStyle: FontStyle.normal,  // 字体风格
                      ),)),
                      ButtonSegment(value: false, label: Text('手机号注册',style: TextStyle(
                        color: ExtensionColor.btnColor.toColor(),           // 文本颜色
                        fontSize: 14,                 // 字体大小
                        fontWeight: FontWeight.bold,  // 字体粗细
                        fontStyle: FontStyle.normal,  // 字体风格
                      ),)),
                    ],
                    selected: {controller.isEmailMode.value},
                    onSelectionChanged: (Set<bool> newSelection) {
                      controller.toggleRegisterMode();
                    },
                  )),
                  SizedBox(height: 16),
                  Obx(() => controller.isEmailMode.value
                      ? TextFormField(
                          controller: controller.emailController,
                          decoration: InputDecoration(
                            labelText: '邮箱',
                            prefixIcon: Icon(Icons.email,color: ExtensionColor.btnColor.toColor(),),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: controller.validateEmail,
                        )
                      : TextFormField(
                          controller: controller.phoneController,
                          decoration: InputDecoration(
                            labelText: '手机号',
                            prefixIcon: Icon(Icons.phone,color: ExtensionColor.btnColor.toColor(),),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: controller.validatePhone,
                        )),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.verificationCodeController,
                          decoration: InputDecoration(
                            labelText: '验证码',
                            prefixIcon: Icon(Icons.lock,color: ExtensionColor.btnColor.toColor(),),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: controller.validateVerificationCode,
                        ),
                      ),
                      SizedBox(width: 16),
                      Obx(() => ElevatedButton(
                            onPressed: controller.isSendingCode.value
                                ? null
                                : controller.sendVerificationCode,
                            child: Text(controller.isSendingCode.value
                                ? '${controller.countdown}s'
                                : '发送验证码',style:TextStyle(
                                            color: ExtensionColor.btnColor.toColor(),           // 文本颜色
                                            fontSize: 15,                 // 字体大小
                                            fontWeight: FontWeight.bold,  // 字体粗细
                                            fontStyle: FontStyle.normal,  // 字体风格
                                            ) ,),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          )),
                    ],
                  ),
                  SizedBox(height: 16),
                  Obx(() => TextFormField(
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
                      )),
                  SizedBox(height: 16),
                  Obx(() => TextFormField(
                        controller: controller.confirmPasswordController,
                        obscureText: !controller.isConfirmPasswordVisible.value,
                        decoration: InputDecoration(
                          labelText: '确认密码',
                          prefixIcon: Icon(Icons.lock,color: ExtensionColor.btnColor.toColor(),),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isConfirmPasswordVisible.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed:
                                controller.toggleConfirmPasswordVisibility,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: controller.validateConfirmPassword,
                      )),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: controller.register,
                    child: Text('注册',style: TextStyle(
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
