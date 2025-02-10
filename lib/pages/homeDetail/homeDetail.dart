import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note/main.dart';

import '../home/home_controller.dart';
import '../utils/ImageViewUtil/ImageViewer.dart';
import '../utils/color/extension_color.dart';
import '../utils/language/language.dart';
import 'home_detail_controller.dart';
// import '../../controllers/counter.dart';



class HomedetailPage extends GetView<HomeDetailController> {

  HomedetailPage({super.key});
  // Map<String, dynamic> jsonMap = Map();
  // try {
  // jsonMap = jsonDecode(controller.obsData.value.toString());
  // print(jsonMap);
  // } catch (e) {
  // print("Error: $e");
  // }

  final TextEditingController _titleController = TextEditingController(text: "");
  final TextEditingController _contentCntroller = TextEditingController(text: "");

  /*图片控件*/
  Widget _ImageView(imgPath) {
    if (imgPath == null) {
      return Image.network(
        imgPath,
        width: 80,
        height: 60,
        fit: BoxFit.cover,
      );
    } else {
      return Image.network(
        imgPath,
        width: 80,
        height: 60,
        fit: BoxFit.cover,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Globalization.detail.tr,
        style: TextStyle(fontSize: 20,color: Colors.white),),
        leading: Builder(builder: (context){
          return IconButton(//naviColor
            icon: Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: () => {
              Get.back(),
            },
          );
        }),
        // backgroundColor: ExtensionColor.naviColor.toColor(),
        flexibleSpace: Container(//[ExtensionColor.listViewBgColor1.toColor(), ExtensionColor.listViewBgColor2.toColor()],
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                ExtensionColor.noteBackgroundColor1.toColor(),
                ExtensionColor.noteBackgroundColor2.toColor(),
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
            ),
        ),
        actions: [ //导航栏右侧菜单
          Obx((){
            return IconButton(
                icon: Icon(controller.isEdit.value == false ? Icons.edit : Icons.save),
                padding: EdgeInsets.all(10.0), //
                color: Colors.white,
                onPressed: () {
                  controller.setTextFieldEditStatus();

                });
          }),
        ],
      ),
      body: Obx((){//controller.hotList.toString()得和obx使用，而且只有这么使用生命周期的函数才会调用
        // print("object:"+controller.title.toString());

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            // borderRadius: BorderRadius.all(Radius.circular(10)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomLeft,
              colors: [ExtensionColor.listViewBgColor1.toColor(), ExtensionColor.listViewBgColor2.toColor()],
            ),
          ),
          child: CustomScrollView(

            slivers: <Widget>[
              SliverPadding(
                padding: EdgeInsets.all(20),
                sliver: SliverToBoxAdapter(
                  child: createContiner(),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(20),
                sliver: SliverGrid.count(
                  crossAxisCount: 4,
                  children: List.generate(controller.imageUrls.length, (index){
                    var imageFile = controller.imageUrls[index];
                    Widget image = _ImageView(imageFile);
                    return GestureDetector(
                      onTap: () {
                        print('Item $index clicked');
                        Get.to(
                          ImageViewer(
                            imageUrls: controller.imageUrls,
                            initialIndex: index,
                          ),
                        );
                      },
                      child: Container(
                        color: Color(0x00),//透明
                        alignment: Alignment.center,
                        child: image,
                      ),
                    );
                  }).toList(),),
              ),

            ],
          ),
        );
      }),
    );
  }
  Widget createContiner() {
    _titleController.text =  controller.title.value;
    _contentCntroller.text =  controller.content.value;
    controller.titletext.value = controller.title.value;
    controller.contenttext.value = controller.content.value;

    return Container(
      child: Column(
        children: [
          TextField(
              enabled: controller.isEdit.value == false ? false : true ,
              maxLines: null,
              minLines: 1,
              onChanged: (text){
                // print("title"+text);
                controller.titletext.value = text;
              },
            controller: _titleController,
              style: TextStyle(
                color: Colors.black,           // 文本颜色
                fontSize: 18,                 // 字体大小
                fontWeight: FontWeight.bold,  // 字体粗细
                fontStyle: FontStyle.italic,  // 字体风格
              )),
          TextField(
              maxLines: null,
              minLines: 1,
              onChanged: (text){
                print("content"+text);
                controller.contenttext.value = text;
              },
              enabled: controller.isEdit.value == false ? false : true ,
              controller: _contentCntroller,
              style: TextStyle(
                color: Colors.black,           // 文本颜色
                fontSize: 15,                 // 字体大小
                fontWeight: FontWeight.bold,  // 字体粗细
                fontStyle: FontStyle.italic,  // 字体风格
              )),

          // Text(controller.title.value),
          // Text(controller.content.value),
        ],
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