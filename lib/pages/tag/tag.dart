
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:note/pages/tag/tag_controller.dart';
import 'package:note/pages/tagListView/tag_listView_controller.dart';
import 'package:note/pages/utils/language/language.dart';

import '../search/note_search_bar.dart';
import '../utils/color/extension_color.dart';

class TagPage extends GetView<TagController> {

  const TagPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ExtensionColor.naviColor.toColor(),
        title: Text(Globalization.tag.tr,
          style: TextStyle(fontSize: 20,color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search,color: Colors.white,),
            onPressed: () {
              showSearch(
                context: context,
                delegate: NoteSearchBar(),
              );
            },
          ),
        ],
        flexibleSpace: Container(//[ExtensionColor.listViewBgColor1.toColor(), ExtensionColor.listViewBgColor2.toColor()],
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              ExtensionColor.noteBackgroundColor1.toColor(),
              ExtensionColor.noteBackgroundColor2.toColor(),
              ExtensionColor.noteBackgroundColor3.toColor(),
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
          ),
        ),
      ),
      body: Obx((){
        return Container(
          decoration: BoxDecoration(
            // color: controller.categories[index]['color'],
            // borderRadius: BorderRadius.circular(8.0),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [ExtensionColor.listViewBgColor1.toColor(), ExtensionColor.listViewBgColor2.toColor()],
            ),
          ),
          child: Padding(
              padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
              child: RefreshIndicator(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomLeft,
                        colors: [ExtensionColor.listViewBgColor1.toColor(), ExtensionColor.listViewBgColor2.toColor()],
                      ),
                    ),
                    child: GridView.builder(
                      padding: EdgeInsets.all(8.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 每行显示的列数
                        childAspectRatio: 3 / 2, // 子项的宽高比
                        crossAxisSpacing: 8.0, // 列间距
                        mainAxisSpacing: 8.0, // 行间距
                      ),
                      itemCount: controller.categories.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // 点击事件处理
                            // controller.getContentByTagid(index);
                            Map map = controller.getCategoriesId(index);
                            Get.toNamed("/TagListviewPage",arguments: {
                              "map":map
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              gradient: controller.categories[index]['gradient'],
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    controller.categories[index]['icon'],
                                    color: Colors.white,
                                    size: 40.0,
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    controller.categories[index]['title'],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  onRefresh:() async {
                    controller.categories.clear();
                    controller.getTagsList();
                  })
          ),
        );
      })
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