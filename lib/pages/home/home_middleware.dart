import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

class HomeMiddleWare extends GetMiddleware{

  @override
  RouteSettings? redirect(String? route){
    print("-------");
    print(route);
    return null;  //不做任何操作

    //没有权限跳转到登录页面
    // return const RouteSettings(name:"/login",arguments:{});
  }
}