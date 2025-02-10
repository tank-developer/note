import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:note/pages/login/login_page.dart';
import 'package:note/pages/userCenter/user_center_controller.dart';
import 'package:note/pages/utils/language/language.dart';

import '../AuthService/AuthService.dart';
import '../utils/color/extension_color.dart';

class UserCenterControllerPage extends GetView<UserCenterController> {
  UserCenterControllerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Globalization.persional.tr),
      ),
      body: Obx(() {
        // 确保 userMap 是响应式的，并且当它变化时，这个 ListView 会重新构建
        return ListView.builder(
          itemCount: controller.userMap.length , // 假设 userMap 是一个 Map，并且它的键的数量决定了列表项的数量
          itemBuilder: (BuildContext ctxt, int index) {
            // 这里假设 userMap 的键是有序的，并且你想要显示每个键对应的值
            // 请确保 userMap.length 大于等于 index + 1
            if (index == 0){//'resources/userlogo.png',//CircleAvatar。GestureDetector
              return GestureDetector(
                onTap: (){
                  print("object");
                },
                child: CircleAvatar(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueAccent,
                  radius: 50,
                  child: controller.userMap["avatar"] != null ? loadImage() : loadName(),
                ),
              );
            }
            if (index == 1){
              var userController = TextEditingController(text: controller.userMap["username"]);
              return TextField(
                style: TextStyle(
                  color: Colors.black,           // 文本颜色
                  fontSize: 18,                 // 字体大小
                  fontWeight: FontWeight.bold,  // 字体粗细
                  fontStyle: FontStyle.normal,  // 字体风格
                ),
                enabled: false,
                controller: userController,
                  decoration: InputDecoration(
                    // labelText: "请输入标题",
                    prefixIcon: Icon(Icons.people,color: ExtensionColor.naviColor.toColor(),),
                  )
                // keyboardType: TextInputType.text,
              );
            }
            if (index == 2){
              var contracrController = TextEditingController(text: controller.userMap["phone"] == null ? controller.userMap["email"] : controller.userMap["phone"]);
              return TextField(
                style: TextStyle(
                  color: Colors.black,           // 文本颜色
                  fontSize: 18,                 // 字体大小
                  fontWeight: FontWeight.bold,  // 字体粗细
                  fontStyle: FontStyle.normal,  // 字体风格
                ),
                  enabled: false,
                  controller: contracrController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(controller.userMap["phone"] != null ? Icons.phone : Icons.email ,color: ExtensionColor.naviColor.toColor(),),
                  )
                // keyboardType: TextInputType.text,
              );
            }
            if (index == 3){//GestureDetector
              var contracrController = TextEditingController(text: controller.userMap["logout"]);
              return GestureDetector(
                onTap: () {
                  // Get.offAllNamed("/");
                  logout();
                },
                child: TextField(
                    style: TextStyle(
                      color: Colors.black,           // 文本颜色
                      fontSize: 18,                 // 字体大小
                      fontWeight: FontWeight.bold,  // 字体粗细
                      fontStyle: FontStyle.normal,  // 字体风格
                    ),
                    enabled: false,
                    controller: contracrController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.logout,color: ExtensionColor.naviColor.toColor(),),
                    )
                  // keyboardType: TextInputType.text,
                ),
              );
            }
          },
        );
      }),
    );
  }

 Widget loadName(){
   var username = controller.userMap["username"];
   return Text(username[0], style: TextStyle(fontSize: 23),);
  }
  Widget loadImage() {
    var avatar = controller.userMap["avatar"];
    return FadeInImage.assetNetwork(
      placeholder: 'resources/userlogo.png',
      image: avatar,
    );
  }

  void logout() {
    Get.defaultDialog(
      title: "退出",
      middleText: "您确定要退出登录吗?",
      //确定按钮
      confirm: ElevatedButton(
          onPressed: () async{
            //单击后删除弹框
            Get.back();
            final authService = AuthService();
            await authService.logout();
            Get.offAll(LoginPage());
          },
          child: Text("确定",style: TextStyle(
            color: Colors.red,           // 文本颜色
            fontSize: 15,                 // 字体大小
            fontWeight: FontWeight.bold,  // 字体粗细
            fontStyle: FontStyle.normal,  // 字体风格
          ),)),
      //取消按钮
      cancel: ElevatedButton(
          onPressed: () {
            //单击后删除弹框
            Get.back();
          },
          child: Text("取消" , style: TextStyle(
            color: ExtensionColor.btnColor.toColor(),           // 文本颜色
            fontSize: 15,                 // 字体大小
            fontWeight: FontWeight.bold,  // 字体粗细
            fontStyle: FontStyle.normal,  // 字体风格
          ),)),
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
