

// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:note/pages/search/note_search_bar.dart';
import 'package:note/pages/search/search_controller.dart';

import '../AuthService/AuthService.dart';
import '../utils/color/extension_color.dart';
// import 'package:note/pages/search/search_controller.dart';

class SearchNotPage extends GetView<SearchNoteController> {
  const SearchNotPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("data"),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            showSearch(
              context: context,
              delegate: NoteSearchBar(),
            );
          },
        ),
      ],),
      body: Obx((){
        return RefreshIndicator(
          child: Container(
            // color: Colors.grey[200], // 这里设置背景颜色为浅灰色
            child: getListViewBuilder(),

          ), onRefresh: () async {
          final authService = AuthService();
          String dateStore = await authService.getDate();
          DateTime date = DateTime.parse(dateStore);
          // controller.itemList.clear();
          // controller.getHotList(date.toString());
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

        return getListBody(item);
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
                    Text(item["content"],
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
}
extension on String {
  toColor() {
    final hexCode = replaceFirst('#', '');
    final alphaChannel = hexCode.length == 8 ? hexCode.substring(0, 2) : 'FF';
    final rgbChannel = hexCode.length == 8 ? hexCode.substring(2) : hexCode;
    return Color(int.parse('$alphaChannel$rgbChannel', radix: 16));
  }
}
