


import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note/pages/utils/language/language.dart';

import '../../utils/color/extension_color.dart';
// import '../../utils/language/language.dart';


/*图片控件*/
Widget _ImageView(imgPath) {
  if (imgPath == null) {
    return Center(
      child: Text("请选择图片或拍照"),
    );
  } else {
    return Image.file(
      imgPath,
    );
  }
}

Widget createContiner(TextEditingController titleController,TextEditingController contentController){
  return Container(
    child: Wrap(
      children: [
        TextField(
          style: TextStyle(
            color: Colors.black,           // 文本颜色
            fontSize: 18,                 // 字体大小
            fontWeight: FontWeight.bold,  // 字体粗细
            fontStyle: FontStyle.italic,  // 字体风格
          ),
          controller: titleController,
          maxLines: null,
          minLines: 1,
          onChanged: (text){
          },
          decoration: InputDecoration(
            labelText: Globalization.inputTitle.tr,
            // icon: Icon(Icons.text_fields),
            // hintText: "请输入标题",
            prefixIcon: Icon(Icons.text_fields,color: ExtensionColor.naviColor.toColor(),),
          ),
          // keyboardType: TextInputType.text,
        ),
        TextField(
          style: TextStyle(
            color: Colors.black,           // 文本颜色
            fontSize: 15,                 // 字体大小
            fontWeight: FontWeight.bold,  // 字体粗细
            fontStyle: FontStyle.italic,  // 字体风格
          ),
          controller: contentController,
          maxLines: null,
          minLines: 1,
          onChanged: (text){
            print("object");
          },
          decoration: InputDecoration(
              labelText: Globalization.inputContent.tr,
              // icon: Icon(Icons.text_fields),
              // hintText: "请输入内容",
              prefixIcon: Icon(Icons.text_fields,color: ExtensionColor.naviColor.toColor(),)
          ),
        ),
      ],
    ),
  );
}

List<Widget> getTwoWidget(List<File> imageFileList,TextEditingController titleController,TextEditingController contentController){
  return [
    SliverPadding(
      padding: EdgeInsets.only(left: 10,top: 20,right: 10,bottom: 10),
      sliver: SliverToBoxAdapter(
        child: createContiner(titleController, contentController),
      ),
    ),
    SliverPadding(
      padding: EdgeInsets.all(5),
      sliver: SliverGrid.count(
        crossAxisCount: 4,
        children: List.generate(imageFileList.length, (index){
          var imageFile = imageFileList[index];
          Widget iamge = _ImageView(imageFile);
          return Container(
            color: Color(0x00),//透明
            alignment: Alignment.center,
            child: iamge,
          );
        }).toList(),),
    )];
}
List<Widget> getThreeWidget(String tagStr,List<File> imageFileList,TextEditingController titleController,TextEditingController contentController){
  return [
    SliverPadding(
      padding: EdgeInsets.only(left: 10,top: 20,right: 10,bottom: 10),
      sliver: SliverToBoxAdapter(
        child: createContiner(titleController, contentController),
      ),
    ),
    SliverPadding(
      padding: EdgeInsets.all(5),
      sliver: SliverToBoxAdapter(//tagStr
          child: Padding(
              padding: EdgeInsets.all(5.0),  // 页面内边距
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,  // 居左对齐
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),  // 内边距
                    decoration: BoxDecoration(
                      color: Colors.blue,  // 背景颜色
                      borderRadius: BorderRadius.circular(8.0),  // 圆角
                    ),
                    child: Text(
                      tagStr,
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ],
              )
          )
      ),
    ),
    SliverPadding(
      padding: EdgeInsets.all(5),
      sliver: SliverGrid.count(
        crossAxisCount: 4,
        children: List.generate(imageFileList.length, (index){
          var imageFile = imageFileList[index];
          Widget iamge = _ImageView(imageFile);
          return Container(
            color: Color(0x00),//透明
            alignment: Alignment.center,
            child: iamge,
          );
        }).toList(),),
    )];
}



extension on String {
  toColor() {
    final hexCode = replaceFirst('#', '');
    final alphaChannel = hexCode.length == 8 ? hexCode.substring(0, 2) : 'FF';
    final rgbChannel = hexCode.length == 8 ? hexCode.substring(2) : hexCode;
    return Color(int.parse('$alphaChannel$rgbChannel', radix: 16));
  }
}
