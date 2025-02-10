
import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note/pages/inputText/action/input_text_action.dart';
import 'package:note/pages/utils/inputDialog/Input_dialog.dart';
import 'package:note/pages/utils/language/language.dart';
import 'package:note/pages/utils/urls.dart';
// import 'package:image_picker/image_picker.dart';

import '../AuthService/AuthService.dart';
import '../media/TakePictureScreen.dart';
import '../utils/color/extension_color.dart';
import 'pages/input_text_common_pages.dart';
// import 'package:get/get.dart';
// import 'package:flutter/cupertino.dart';


class InputtextPage extends StatefulWidget {
  const InputtextPage({super.key});
  @override
  State<InputtextPage> createState() => _InputtextPageState();
}

class _InputtextPageState extends State<InputtextPage> {
  // ImagePicker获取内容后返回的对象是XFile
  XFile? image;
  File? selectedImage;

  List<XFile>? imageList;
  XFile? video;
  List<File> imageFileList = [];
  var titleController;
  var contentController;

  String tagStr = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController();
    titleController.addListener(() {});
    contentController = TextEditingController();
    contentController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ExtensionColor.naviColor.toColor(),
        leading: Builder(builder: (context){
          return IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: () => {
              Navigator.pop(context),
            },
          );
        }),
        title: Text("Note",style: TextStyle(fontSize: 20,color: Colors.white),),
        actions: [_popupMenuButton(context)],
        flexibleSpace: Container(//[ExtensionColor.listViewBgColor1.toColor(), ExtensionColor.listViewBgColor2.toColor()],
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              ExtensionColor.noteBackgroundColor1.toColor(),
              ExtensionColor.noteBackgroundColor2.toColor(),
              ExtensionColor.noteBackgroundColor3.toColor(),
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
          ),
        ),),
        backgroundColor: Colors.white,
      body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            // 触摸收起键盘
            FocusScope.of(context).requestFocus(FocusNode());
          },
        child: Container(
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
            slivers: tagStr.length == 0 ? getTwoWidget(imageFileList, titleController, contentController):getThreeWidget(tagStr, imageFileList, titleController, contentController),
          ),
        )
      ),
      floatingActionButton: Container(
        height: 50, //调整FloatingActionButton的大小
        width: 50,
        // padding: const EdgeInsets.all(5),
        // margin: const EdgeInsets.only(top: 5), //调整FloatingActionButton的位置
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: FloatingActionButton(
            backgroundColor: Colors.white,
            child: Icon(Icons.save,color: ExtensionColor.listViewBgColor2.toColor(),),
            onPressed: () {
              if (titleController.text == ""){
                titleController.text = "";
              }
              if (titleController.text == ""){
                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('请输入内容')));
                Get.snackbar("内容", "请输入内容");
                return;
              }
              //保存数据在下拉这里完成
              if (tagStr.isEmpty){
                submitData(imageFileList, context, contentController, titleController);
              }else{
                submitDataAndTag(imageFileList, context, contentController, titleController, tagStr);
              }
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  PopupMenuButton _popupMenuButton(BuildContext context) {
    // 使用ImagePicker前必须先实例化
    final ImagePicker _imagePicker = ImagePicker();
    return PopupMenuButton(
      itemBuilder: (BuildContext context){
        return [
          PopupMenuItem(child: Text(Globalization.album.tr),value: Globalization.album.tr,),
          PopupMenuItem(child: Text(Globalization.takePicture.tr),value: Globalization.takePicture.tr,),
          PopupMenuItem(child: Text(Globalization.tag.tr),value: Globalization.tag.tr,),
        ];
      },
      // icon: Icon(Icons.add),
      child: Center(
        child: IconButton(
          onPressed: null,
          icon: Icon(Icons.more_horiz),
          disabledColor: Colors.white,
        ),
      ),
      onSelected: (object) async {
        // print(object);
        if (object.toString() == Globalization.takePicture.tr){
          _selectCamera(_imagePicker);
        }
        if (object.toString() == Globalization.album.tr){
          _openAlbum(_imagePicker);
        }
        if (object.toString() == Globalization.tag.tr){
          _addTag();        }
      },
      onCanceled: (){
        print("onCanceled");
      },
    );
  }

  void _selectCamera(ImagePicker _imagePicker) async {
    XFile? photo = await _imagePicker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
    );
    if (photo != null) {
      image = photo;
    }
    setState(() {
      selectedImage = File(image!.path); // won't have any error now
      imageFileList.add(selectedImage!);
    });
  }

  void _openAlbum(ImagePicker _imagePicker) async{
    XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) this.image = image;
    setState(() {
      selectedImage = File(image!.path);// won't have any error now
      imageFileList.add(selectedImage!);
    });
  }
  void _addTag() {
    _showInputDialog(context).then((value) => {
      print("value"+value),
      setState(() {
        tagStr = value;
      }),
    });
  }
  Future<String> _showInputDialog(BuildContext context) async {
    String inputText = await showDialog(
      context: context,
      builder: (BuildContext context) => InputDialog(title: Text("请输入标签".tr)),
    );
    return inputText;
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


