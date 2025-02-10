import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note/pages/tag/tag.dart';
import 'package:get/get.dart';
import 'package:note/pages/utils/color/extension_color.dart';
import 'package:note/pages/utils/language/language.dart';

import 'home/home.dart';

class Tabs extends StatefulWidget{
  final int index;
  const Tabs({super.key,this.index=0});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TabsState();
  }
}

class _TabsState extends State<Tabs>{
  late int _currentIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentIndex=widget.index;
  }

  final List<Widget> _pages = const [
    HomePage(),
    TagPage(),
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("data1"),
      //   actions: [IconButton(
      //       icon: Icon(Icons.edit),
      //       padding: EdgeInsets.all(10.0), //
      //       onPressed: () {
      //
      //       }),
      //   ],
      // ),

      body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: ExtensionColor.listViewBgColor2.toColor(),
            fixedColor: ExtensionColor.naviColor.toColor(), //选中的颜色
            unselectedItemColor: Colors.grey,
            // iconSize:35,           //底部菜单大小
            currentIndex: _currentIndex, //第几个菜单选中
            type: BottomNavigationBarType.fixed, //如果底部有4个或者4个以上的菜单的时候就需要配置这个参数
            onTap: (index) {
              //点击菜单触发的方法
              //注意
              setState(() {
                _currentIndex = index;
              });
            },
            items:  [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: Globalization.note.tr),
              BottomNavigationBarItem(icon: Icon(Icons.category), label: Globalization.tag.tr),
            ]
        ),
      floatingActionButton: Container(
        height: 50, //调整FloatingActionButton的大小
        width: 50,
        // padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5), //调整FloatingActionButton的位置
        decoration: BoxDecoration(
          color: ExtensionColor.btnColor.toColor(),
          borderRadius: BorderRadius.circular(25),
        ),
        child: FloatingActionButton(
            backgroundColor: Colors.white,
            child:  Icon(Icons.edit,color: ExtensionColor.listViewBgColor2.toColor(),),
            onPressed: () {
              Get.toNamed("/InputtextPage",arguments: {
                "id":3456
              });

              // Get.bottomSheet(
              //
              //     backgroundColor: Colors.white,
              //     Container(
              //       padding: const EdgeInsets.all(20.0),
              //       child: Wrap(
              //         children: [
              //           TextField(
              //               decoration: InputDecoration(
              //                 labelText: "请输入标题",
              //                 // icon: Icon(Icons.title),
              //                 hintText: "请输入标题",
              //                 prefixIcon: Icon(Icons.title)
              //               ),
              //           ),
              //
              //           TextField(
              //             maxLines: null,
              //             minLines: 1,
              //             decoration: InputDecoration(
              //                 labelText: "请输入内容",
              //                 // icon: Icon(Icons.content_copy),
              //                 hintText: "请输入内容",
              //                 prefixIcon: Icon(Icons.content_copy)
              //
              //             ),
              //           ),
              //        ],
              //   ),
              // ));
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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