


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageViewer extends StatelessWidget {
  final List<String> imageUrls;
  final int initialIndex;

  ImageViewer({required this.imageUrls, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    print('Image URLs: $imageUrls');
    print('Initial Index: $initialIndex');

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // 关闭当前页面并返回到上一个页面
          Navigator.pop(context);
        },
        child: Stack(
          children: [
            PhotoViewGallery.builder(
              itemCount: imageUrls.length,
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(imageUrls[index]),
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: PhotoViewComputedScale.covered * 2.0,
                  initialScale: PhotoViewComputedScale.contained,
                  heroAttributes: PhotoViewHeroAttributes(tag: imageUrls[index]),
                );
              },
              scrollPhysics: const BouncingScrollPhysics(), // 确保允许水平滑动
              allowImplicitScrolling: true, // 确保允许隐式滚动
              backgroundDecoration: BoxDecoration(
                color: Colors.black,
              ),
              pageController: PageController(initialPage: initialIndex), // 初始化页面控制器
              loadingBuilder: (context, event) {
                if (event == null) return Container();
                return Center(
                  child: CircularProgressIndicator(
                    value: event.cumulativeBytesLoaded / event.expectedTotalBytes!,
                  ),
                );
              },
            ),
            // 添加一个透明的覆盖层，以便捕获点击事件
            Positioned.fill(
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

