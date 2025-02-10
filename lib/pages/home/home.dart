import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:note/main.dart';
import 'package:note/pages/home/home_controller.dart';
import 'package:note/pages/utils/language/language.dart';

import '../AuthService/AuthService.dart';
import '../utils/calendarUtil/MSCustomDatePicker.dart';
import '../utils/color/extension_color.dart';
// import '../controllers/search.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context){
          return IconButton(
            icon: Icon(Icons.menu,color: Colors.white,),
            onPressed: () => {
              Scaffold.of(context).openDrawer(),
            },
          );
        }),
        // backgroundColor: ExtensionColor.naviColor.toColor(),
        title: Obx((){
          return Text(controller.dateObs.toString(),
            style: TextStyle(fontSize: 20,color: Colors.white),
          );
        }),
        // centerTitle: true,
        flexibleSpace: Container(//[ExtensionColor.listViewBgColor1.toColor(), ExtensionColor.listViewBgColor2.toColor()],
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  ExtensionColor.noteBackgroundColor1.toColor(),
                  ExtensionColor.noteBackgroundColor2.toColor(),
                  ExtensionColor.noteBackgroundColor3.toColor(),
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
              ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.date_range),
              padding: EdgeInsets.all(10.0), //
              color: Colors.white,
              onPressed: () {
                controller.selectDate(context);
              }),
        ],
          // toolbarHeight: ,
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomLeft,
              colors: [ExtensionColor.listViewBgColor1.toColor(), ExtensionColor.listViewBgColor2.toColor()],
            ),
          ),
          child: Column(
            children: [
              Obx((){
                return Row(
                  children:  [
                    Expanded(
                        flex: 1,
                        child: UserAccountsDrawerHeader(
                          accountName:  Text(Globalization.user.tr+":"+controller.userMap["username"].toString()),//"邮箱:"+controller.userMap["email"].toString()
                          accountEmail: getEmailOrPhone(),
                          // otherAccountsPictures:[
                          //   Image.network("https://www.itying.com/images/flutter/1.png"),
                          //   Image.network("https://www.itying.com/images/flutter/2.png"),
                          //   Image.network("https://www.itying.com/images/flutter/3.png"),
                          // ],
                          currentAccountPicture: CircleAvatar(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blueAccent,
                            radius: 50,
                            child: loadName(),
                          ),
                          decoration:  BoxDecoration(
                            // color: "#2E8B57".toColor(),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("resources/backgroundImage.png"),
                            ),
                            gradient: LinearGradient(colors: [
                              ExtensionColor.noteBackgroundColor1.toColor(),
                              ExtensionColor.noteBackgroundColor2.toColor(),
                              ExtensionColor.noteBackgroundColor3.toColor(),
                            ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                          ),
                        ))
                  ],
                );
              }),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.people,color: ExtensionColor.naviColor.toColor(),),
                ),
                title: Text(Globalization.persional.tr,style: TextStyle(color: Colors.black),),
                onTap:() {
                  // Navigator.pop(context);
                  Get.toNamed("/UserCenterPage",arguments: {
                    "id":""
                  });
                },
              ),
              const Divider(),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.settings,color: ExtensionColor.naviColor.toColor(),),
                ),
                title: Text(Globalization.setting.tr,style: TextStyle(color: Colors.black),),
                onTap: (){
                  // Navigator.pop(context);
                  Get.toNamed("/SysSettingPage",arguments: {
                    "id":""
                  });
                },
              ),
              const Divider(),
            ],
          ),
        )
      ),
      body: Obx((){
        return RefreshIndicator(
            child: Container(
              // color: Colors.grey[200], // 这里设置背景颜色为浅灰色
              child: getListViewBuilder(),
              decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomLeft,
                  colors: [ExtensionColor.listViewBgColor1.toColor(), ExtensionColor.listViewBgColor2.toColor()],
                ),
              ),
            ), onRefresh: () async {
                final authService = AuthService();
                // authService.saveDate(date)
                String dateStore = await authService.getDate();
                DateTime date = DateTime.parse(dateStore);
                controller.hotList.clear();
                controller.getHotList(date.toString());
             },
        );
      }),
    );
  }
  ListView getListViewBuilder(){
    return ListView.builder(
      itemCount: controller.hotList.length,
      itemBuilder: (context, index) {
        Map item = controller.hotList[index];
        return Slidable(
          key: ValueKey("$index"),
          //滑动方向
          direction: Axis.horizontal,
          // The end action pane is the one at the right or the bottom side.
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (BuildContext context) {
                  var fileUrls = item["image"].toString();
                  var imageArr = fileUrls.split(",");
                  controller.deleteImages(imageArr);
                  controller.deleteItem(index);
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: '删除',
              ),
            ],
          ),
          //列表显示的子Item
          child: getListBody(item),
        );
      },
    );
  }

  ListBody getListBody(Map item){
    var imageUrlString = item["image"].toString();
    var imageArr = imageUrlString.split(",");
    return ListBody(
      children: [
        InkWell(
          onTap: () {
            Get.toNamed("/HomedetailPage",arguments: {
              "id":item["id"]
            });
          },
          child: Container(
              height: 170,
              padding: EdgeInsets.all(10),
              margin: EdgeInsetsDirectional.only(top:10.0,start: 15.0,end: 15.0,bottom: 0.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomLeft,
                  colors: [ExtensionColor.noteBackgroundColor1.toColor(), ExtensionColor.noteBackgroundColor2.toColor(),ExtensionColor.noteBackgroundColor3.toColor()],
                  // colors: [Colors.white, Colors.white],
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsetsDirectional.only(top:0.0,start: 10.0,end: 0.0,bottom: 0.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item["title"],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis, //长度溢出后显示省略号
                      style: TextStyle(
                          color: ExtensionColor.noteTitleColor.toColor(),           // 文本颜色
                          fontSize: 18,                 // 字体大小
                          fontWeight: FontWeight.bold,  // 字体粗细
                          fontStyle: FontStyle.italic,  // 字体风格
                      )),
                    Text(item["content"],
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,//长度溢出后显示省略号
                      style: TextStyle(
                          color: ExtensionColor.noteTitleColor.toColor(),           // 文本颜色
                          fontSize: 15,                 // 字体大小
                          fontWeight: FontWeight.bold,  // 字体粗细
                          fontStyle: FontStyle.italic,  // 字体风格
                      )),
                    Spacer(),
                    Container(
                      // width: 40,
                      height: 40,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: imageArr.length,
                          itemBuilder: (content,index){
                            var item = imageArr[index];
                            return Container(
                              height: 40,
                              width: 40,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                // color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Image.network(
                                item,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            );
                          }),
                    ),

                    // Container(
                    //   height: 40,
                    //   width: 40,
                    //   clipBehavior: Clip.hardEdge,
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.all(Radius.circular(20)),
                    //   ),
                    //   child: Image.network(
                    //     imageArr0,
                    //     width: 60,
                    //     height: 60,
                    //     fit: BoxFit.cover,
                    //   ),
                    // )
                  ],
                ),
              )
          ),
        ),
      ],
    );
  }



  //------------------------------------------------------------------------------------------------
  List<Widget> getList(){
    return controller.hotList.map((value){
      var updateAt = value["updateAt"];
      var createAt = value["createAt"];
      return getItem(value);
    }).toList();
  }
  /// 获取子项目
  Widget getItem(Map item) {
    var imageStr = item["image"];
    print("map=="+item.toString());
    List imageStrList =imageStr.split(',');
    var imageUrl0 = imageStrList[0].toString();
    // return getListTitle(imageUrl0, item);
    return getListBody(item);
  }

  ListView getListView(){
    return ListView(
      children: getList(),
    );
  }


  List<Widget> getNullListView(){
    List<Widget> list = [];
    print("dateObs===="+controller.dateObs.value);
    list.add(Text("data"));
    return list;
  }

  ListTile getListTitle(String imageUrl0,Map item){
    return ListTile(
      // 前部图片
      leading: Image.network(
        imageUrl0,
        width: 80,
        height: 60,
        fit: BoxFit.cover,
      ),
      // 标题
      title: Text(item["title"]),
      // 副标题
      subtitle: Text(item["content"]),
      // 后部箭头
      trailing: Icon(Icons.keyboard_arrow_right_outlined),
      onTap: () {
        // print('${item["id"]}');
        Get.toNamed("/HomedetailPage",arguments: {
          "id":item["id"]
        });

      },
      onLongPress: () {
        print('${item["userId"]}');
      },
    );
  }

  Widget loadName(){
    var username = controller.userMap["username"];
    return Text(username[0], style: TextStyle(fontSize: 23),);
  }

  Widget getEmailOrPhone() {
    if (controller.userMap["phone"] != null){
      return Text(Globalization.phone.tr+"电话:"+controller.userMap["phone"].toString());
    }
    if (controller.userMap["email"] != null){
      return Text(Globalization.email.tr+":"+controller.userMap["email"].toString());
    }
    return Text("无联系方式");
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