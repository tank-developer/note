




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note/pages/sysSetting/sys_setting_controller.dart';

import '../utils/color/extension_color.dart';
import '../utils/language/language.dart';

class SysSettingPage extends GetView<SysSettingController> {
  SysSettingPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Globalization.setting.tr),),
      body: CustomScrollView(

              slivers: [
                SliverPadding(
                  padding: EdgeInsets.all(0),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.all(8),
                        child: InkWell(
                            onTap: (){
                              popbottomLanguageView();
                            },
                            child: AbsorbPointer(
                              absorbing: true,
                              child: TextField(
                                  style: TextStyle(
                                    color: Colors.black,           // 文本颜色
                                    fontSize: 18,                 // 字体大小
                                    fontWeight: FontWeight.bold,  // 字体粗细
                                    fontStyle: FontStyle.normal,  // 字体风格
                                  ),
                                  enabled: false,
                                  controller: TextEditingController(text: Globalization.language.tr),
                                  decoration: InputDecoration(
                                    // labelText: "请输入标题",
                                    icon: Icon(Icons.language,color: ExtensionColor.listViewBgColor2.toColor(),),
                                    // prefixIcon: Icon(Icons.mode_comment,color: ExtensionColor.btnColor.toColor(),),
                                  )
                                // keyboardType: TextInputType.text,
                              ),
                            )
                        )
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.all(0),
                  sliver: SliverToBoxAdapter(
                  child: Container(
                      padding: EdgeInsets.all(8),
                      child: InkWell(
                      onTap: (){
                      //   PrivatePage
                        Get.toNamed("/PrivatePage",arguments: {
                        });
                      },
                      child: AbsorbPointer(
                        absorbing: true,
                        child: TextField(
                            style: TextStyle(
                              color: Colors.black,           // 文本颜色
                              fontSize: 18,                 // 字体大小
                              fontWeight: FontWeight.bold,  // 字体粗细
                              fontStyle: FontStyle.normal,  // 字体风格
                            ),
                            enabled: false,
                            controller: TextEditingController(text: Globalization.private.tr),
                            decoration: InputDecoration(
                              // labelText: "请输入标题",
                              icon: Icon(Icons.text_fields,color: ExtensionColor.listViewBgColor2.toColor(),),
                              // prefixIcon: Icon(Icons.mode_comment,color: ExtensionColor.btnColor.toColor(),),
                            )
                          // keyboardType: TextInputType.text,
                        ),
                      )
                    )
                  ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.all(0),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                        padding: EdgeInsets.all(8),
                        child: InkWell(
                            onTap: (){
                              // popbottomView();
                              popbottomView();
                            },
                            child: AbsorbPointer(
                              absorbing: true,
                              child: TextField(
                                  style: TextStyle(
                                    color: Colors.black,           // 文本颜色
                                    fontSize: 18,                 // 字体大小
                                    fontWeight: FontWeight.bold,  // 字体粗细
                                    fontStyle: FontStyle.normal,  // 字体风格
                                  ),
                                  enabled: false,
                                  controller: TextEditingController(text: Globalization.about.tr),
                                  decoration: InputDecoration(
                                    // labelText: "请输入标题",
                                    icon: Icon(Icons.developer_mode,color: ExtensionColor.listViewBgColor2.toColor(),),
                                    // prefixIcon: Icon(Icons.mode_comment,color: ExtensionColor.btnColor.toColor(),),
                                  )
                                // keyboardType: TextInputType.text,
                              ),
                            )
                        )
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.all(8),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                        child: InkWell(
                            onTap: (){
                              resetAcctount();
                            },
                            child: AbsorbPointer(
                              absorbing: true,
                              child: TextField(
                                  style: TextStyle(
                                    color: Colors.red,           // 文本颜色
                                    fontSize: 18,                 // 字体大小
                                    fontWeight: FontWeight.bold,  // 字体粗细
                                    fontStyle: FontStyle.normal,  // 字体风格
                                  ),
                                  enabled: false,
                                  controller: TextEditingController(text: Globalization.deleteAcctoun.tr),
                                  decoration: InputDecoration(
                                    // labelText: "请输入标题",
                                    icon: Icon(Icons.delete_forever,color: ExtensionColor.listViewBgColor2.toColor(),),
                                    // prefixIcon: Icon(Icons.mode_comment,color: ExtensionColor.btnColor.toColor(),),
                                  )
                                // keyboardType: TextInputType.text,
                              ),
                            )
                        )
                    ),
                  ),
                )
              ]
      ),
    );
  }

  void popbottomView() {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        height: 200,
        child: Column(
          children: [
               ListTile(
                onTap: (){
                  // Get.changeTheme(ThemeData.light());
                  // Get.back();
                },
                leading: Icon(Icons.supervised_user_circle),
                title: Text(
                  "网名：大壮",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ListTile(
                onTap: (){
                  // Get.changeTheme(ThemeData.dark());
                  // Get.back();
                },
                leading: const Icon(Icons.work_history),
                title: const Text(
                "职业：个人开发者",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
      ),
    ),
    );
  }

  void resetAcctount() {
    Get.defaultDialog(
      title: "注销",
      middleText: "注销后账号、笔记都会失去，您确定要注销账户吗?",
      //确定按钮
      confirm: ElevatedButton(
          onPressed: () {
            //单击后删除弹框
            Get.back();
            // controller.dismissAccount();
          },
          child:const Text("确定", style: TextStyle(
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
          child:  Text("取消" ,style: TextStyle(
            color: ExtensionColor.btnColor.toColor(),           // 文本颜色
            fontSize: 15,                 // 字体大小
            fontWeight: FontWeight.bold,  // 字体粗细
            fontStyle: FontStyle.normal,  // 字体风格
          ),)),
    );
  }

  void popbottomLanguageView() {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        height: 200,
        child: Column(
          children: [
            ListTile(
              onTap: (){
                var locale = const Locale("en","US");
                Get.updateLocale(locale);
                Get.back();
              },
              leading: Icon(Icons.language_outlined),
              title: Text(
                Globalization.english.tr,
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: (){
                var locale = const Locale("zh","CN");
                Get.updateLocale(locale);
                Get.back();

              },
              leading: const Icon(Icons.language_rounded),
              title: Text(
                Globalization.china.tr,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
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
