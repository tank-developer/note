import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:note/pages/AuthService/AuthService.dart';
import 'package:note/pages/binding/binding.dart';
// import 'package:note/pages/binding/binding.dart';
import 'package:note/pages/home/home.dart';
// import 'package:note/pages/home/home.dart';
import 'package:note/pages/login/login_page.dart';
import 'package:note/pages/tabs.dart';
import 'package:note/pages/utils/language/language.dart';
// import 'package:note/pages/login/login.dart';
import 'package:note/routers/routers.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final authService = AuthService();
  bool isLoggedIn = await authService.isLoggedIn();

  // runApp(const MyApp());
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  // const MyApp({super.key});
  const MyApp({required this.isLoggedIn});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        translations: Language(),
        locale: const Locale('zh', 'CN'),//默认中文
        fallbackLocale: Locale('en', 'US'),
        initialBinding: AllControllerBinding(),   //全局绑定GetxController
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            appBarTheme: const AppBarTheme(
            centerTitle: true,
          ),
        ),
      // initialRoute: '/',
        defaultTransition: Transition.rightToLeft,
        getPages:AppPage.routes,
        home: isLoggedIn ? Tabs() : LoginPage(),
      );
     }
}

