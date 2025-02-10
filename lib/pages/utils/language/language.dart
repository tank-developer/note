

import 'package:get/get.dart';

class Language extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    "en_US": {
      Globalization.english: "English",
      Globalization.note: "Note",
      Globalization.tag: "Tag",
      Globalization.user: "user",
      Globalization.phone: "phone",
      Globalization.persional: "user info",
      Globalization.setting: "setting",
      Globalization.language: "language",
      Globalization.private: "private protocal",
      Globalization.about: "about developer",
      Globalization.deleteAcctoun : "delete account",
      Globalization.detail : "detail",
      Globalization.inputTitle : "input text",
      Globalization.inputContent : "input text",
      Globalization.album : "album",
      Globalization.takePicture : "take picture",
      Globalization.seleteDate : "select date",
      Globalization.email : "email",
      Globalization.china : "China",

    },
    "zh_CN": {
      Globalization.english: "英语",
      Globalization.note: "笔记",
      Globalization.tag: "标签",
      Globalization.user: "用户",
      Globalization.phone: "电话",
      Globalization.persional: "个人中心",
      Globalization.setting: "系统设置",
      Globalization.language: "语言",
      Globalization.private: "隐私协议",
      Globalization.about: "关于开发者",
      Globalization.deleteAcctoun : "注销账户",
      Globalization.detail : "详情",
      Globalization.inputTitle : "请输入标题",
      Globalization.inputContent : "请输入内容",
      Globalization.album : "相册",
      Globalization.takePicture : "拍照",
      Globalization.seleteDate : "请选择日期",
      Globalization.email : "邮箱",
      Globalization.china : "中文",




    }
  };
}

class Globalization {
  static const String english = "english";
  static const String note = "note";
  static const String tag = "tag";
  static const String user = "user";
  static const String phone = "phone";
  static const String persional = "persional";
  static const String setting = "setting";
  static const String language = "language";
  static const String private = "private";
  static const String about = "about";
  static const String deleteAcctoun = "deleteAcctoun";
  static const String detail = "detail";
  static const String inputTitle = "inputTitle";
  static const String inputContent = "inputContent";
  static const String album = "album";
  static const String takePicture = "takePicture";
  static const String seleteDate = "seleteDate";
  static const String email = "email";
  static const String china = "china";

}

