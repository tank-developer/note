


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note/pages/utils/networkUtil/networkUtil.dart';

import '../AuthService/AuthService.dart';
import 'package:dio/dio.dart' as dio_package;

import '../utils/color/extension_color.dart';
import '../utils/urls.dart';

class NoteSearchBar extends SearchDelegate<String> {
  // 重写 buildSuggestions 方法，返回一个建议列表
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  // 重写 buildLeading 方法，定义搜索框左边的按钮
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, "");
      },
    );
  }

  // 重写 buildResults 方法，当用户完成输入并提交后显示的结果
  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: searchBooks(query),  // 发起网络请求
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());  // 加载中...
        } else if (snapshot.hasError) {
          return Center(child: Text('发生错误：${snapshot.error}'));  // 错误处理
        } else if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              final map = snapshot.data![index];
              var title = map["title"];
              var content = map["content"];
              var image = map["image"];
              var id = map["id"];
              return getListBody(map);
            },
          );
        } else {
          return Center(child: Text('没有找到结果'));  // 没有数据
        }
      },
    );
  }

  // 定义一个异步方法来处理网络请求
  Future<List<dynamic>> searchBooks(String query) async{
    final authService = AuthService();
    String info = await authService.getUserInfo() as String;

    Map<String, dynamic> jsonMap = Map();
    try {
      jsonMap = jsonDecode(info);
      print(jsonMap);
    } catch (e) {
      print("Error: $e");
    }

    var data = jsonMap["data"];
    var token = data["token"];

    // var dio = dio_package.Dio();
    var dio = Networkutil.getDio();

    ///在这里修改 contentType
    dio.options.contentType="multipart/form-data";
    ///请求header的配置
    dio.options.headers["token"]=token;
    final formData = dio_package.FormData.fromMap({
      "searchTerm":query,
    });
    var response = await dio.post(Urls.url_content_search, data: formData);
    Map<String, dynamic> listJsonMap = Map();
    print(response);
    var listJsonMap2;

    listJsonMap = jsonDecode(response.toString());
    listJsonMap2 = listJsonMap["data"];
      // hotList.value = listJsonMap2;
    return listJsonMap2;
  }

  // 重写 buildSuggestions 方法，当用户在搜索框中输入时提供即时建议
  Widget buildSuggestions(BuildContext context) {
    // 构建搜索建议视图
    return FutureBuilder<List<dynamic>>(
      future: searchBooks(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else {
          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              final map = snapshot.data![index];
              var title = map["title"];
              var content = map["content"];
              var image = map["image"];
              var id = map["id"];

              return ListTile(
                title: Text(title),
                subtitle: Text(content),
                onTap: () {
                  print("query:"+query);
                  query = content; // 更新搜索框内容
                  showResults(context); // 显示搜索结果
                },
              );
            },
          );
        }
      },
    );
  }
  Future<List<String>> fetchSuggestions(String query) async {
    // 模拟网络请求
    await Future.delayed(Duration(seconds: 1)); // 模拟网络延迟
    // 假设我们从网络获取到了数据
    return ["Apple", "Banana", "Cherry"].where((item) => item.contains(query)).toList();
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
                  colors: [ExtensionColor.noteBackgroundColor1.toColor(), ExtensionColor.noteBackgroundColor2.toColor()],
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsetsDirectional.only(top:0.0,start: 10.0,end: 0.0,bottom: 0.0),
                decoration: BoxDecoration(
                  // color: controller.categories[index]['color'],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item["title"],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis, //长度溢出后显示省略号
                        style: TextStyle(
                          color: Colors.white,           // 文本颜色
                          fontSize: 18,                 // 字体大小
                          fontWeight: FontWeight.bold,  // 字体粗细
                          fontStyle: FontStyle.italic,  // 字体风格
                        )),
                    Text(item["content"] + "1",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,//长度溢出后显示省略号
                        style: TextStyle(
                          color: Colors.white,           // 文本颜色
                          fontSize: 15,                 // 字体大小
                          fontWeight: FontWeight.bold,  // 字体粗细
                          fontStyle: FontStyle.italic,  // 字体风格
                        )),
                    Spacer(),
                    Container(
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
}
extension on String {
  toColor() {
    final hexCode = replaceFirst('#', '');
    final alphaChannel = hexCode.length == 8 ? hexCode.substring(0, 2) : 'FF';
    final rgbChannel = hexCode.length == 8 ? hexCode.substring(2) : hexCode;
    return Color(int.parse('$alphaChannel$rgbChannel', radix: 16));
  }
}