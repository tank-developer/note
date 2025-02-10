

//组件文件
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputDialog extends StatefulWidget {
  const InputDialog({Key? key, this.hintText = "请输入...", this.title}) : super(key: key);

  final Widget? title; // Text('New nickname'.tr)
  final String? hintText;

  @override
  State<InputDialog> createState() => _InputDialogState(title: this.title, hintText: this.hintText);
}

class _InputDialogState extends State<InputDialog> {
  final TextEditingController _textEditingController = TextEditingController();

  final Widget? title; // Text('New nickname'.tr)
  final String? hintText;
  _InputDialogState({required this.title, required this.hintText});


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: TextField(
          controller: _textEditingController,
          maxLength:12,
          decoration: InputDecoration(hintText: hintText),
          autofocus: true
      ),
      actions: [
        ElevatedButton(
          style:ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.green)),
          onPressed: () {
            Get.back(result: _textEditingController.text);
          },
          child: Text('ok'.tr,style: TextStyle(color: Colors.white)),
        ),
        ElevatedButton(
          style:ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.transparent),elevation:MaterialStateProperty.all(0)),
          onPressed: () {
            Get.back();
          },
          child: Text('cancel'.tr,style: TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }
}

