
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("登录页面")),
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("登录跳转演示,执行登录后返回到上一个页面"),
            const SizedBox(height: 40),
            ElevatedButton(onPressed: () {
              //返回到上一级页面
              // Navigator.of(context).pop();
              Get.back();
            }, child: const Text("执行登录"))
          ],
        ),
      ),
    );
  }
}
