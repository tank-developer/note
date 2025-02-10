
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:note/pages/home/home_binding.dart';
import 'package:note/pages/home/home_middleware.dart';
import 'package:note/pages/homeDetail/homeDetail.dart';
import 'package:note/pages/homeDetail/home_detail_binding.dart';
import 'package:note/pages/private/private_binding.dart';
import 'package:note/pages/private/private_page.dart';
import 'package:note/pages/tag/tag_binding.dart';
// import 'package:note/pages/register.dart';
import '../pages/register/enhanced_register_page.dart';
import '../pages/inputText/inputText.dart';
// import '../pages/login.dart';
import '../pages/login/login_page.dart';
import '../pages/search/search.dart';
import '../pages/search/search_note_binding.dart';
import '../pages/sysSetting/sys_setting_binding.dart';
import '../pages/sysSetting/sys_setting_page.dart';
import '../pages/tabs.dart';
import '../pages/home/home.dart';
import '../pages/tag/tag.dart';
import '../pages/tagListView/tag_listiew_binding.dart';
import '../pages/tagListView/tag_listview.dart';
import '../pages/userCenter/user_center.dart';
import '../pages/userCenter/user_center_bingding.dart';


class AppPage {
  static final routes= [

    GetPage(
        name: "/",
        page: () => LoginPage()
    ),
    GetPage(
        name: "/shop",
        page: () => const Tabs(),
        bindings: [TagBinding(),HomeControllerBinding()]
        // middlewares: [HomeMiddleWare()]
    ),
    GetPage(
        name: "/register", page: () =>  EnhancedRegisterPage()),
        // middlewares:[
        //   ShopMiddleWare()
        // ]),
    GetPage(name: "/InputtextPage", page: () => const InputtextPage()),
        // GetPage(
        //     name: "/registerFirst",
        //     page: () => const RegisterFirstPage(),
        //     transition: Transition.fade),
        // GetPage(
        //     name: "/registerSecond", page: () => const RegisterSecondPage()),
        // GetPage(name: "/registerThird", page: () => const RegisterThirdPage()),

    GetPage(
        name: "/HomedetailPage",
        page: () =>  HomedetailPage(),
        binding: HomeDetailControllerBinding()),
    GetPage(
        name: "/UserCenterPage",
        page: () =>  UserCenterControllerPage(),
        binding: UserCenterBingding()),
    GetPage(
        name: "/TagListviewPage",
        page: () =>  TagListviewPage(),
        binding: TagListiewBinding()),
    GetPage(
        name: "/SearchNotPage",
        page: () =>  SearchNotPage(),
        binding: SearchNoteBinding()),
    GetPage(
        name: "/SysSettingPage",
        page: () =>  SysSettingPage(),
        binding: SysSettingBinding()),
    GetPage(
        name: "/PrivatePage",
        page: () =>  PrivatePage(),
        binding: PrivateBinding()),
    ];

}
