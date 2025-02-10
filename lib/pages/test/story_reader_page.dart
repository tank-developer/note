import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoryController extends GetxController {
  final isSettingsOpen = false.obs;
  final showTouchIndicator = false.obs;
  final touchPosition = Offset.zero.obs;
  
  void toggleSettings() {
    isSettingsOpen.value = !isSettingsOpen.value;
  }
  
  void updateTouchPosition(Offset position) {
    touchPosition.value = position;
    showTouchIndicator.value = true;
    Future.delayed(Duration(seconds: 2), () {
      showTouchIndicator.value = false;
    });
  }
}

class StoryReaderPage extends StatelessWidget {
  final controller = Get.put(StoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTapDown: (details) => controller.updateTouchPosition(details.globalPosition),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF001F3F),  // Dark blue
                Color(0xFF008080),  // Teal
              ],
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                // Top Navigation Bar
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.settings, color: Colors.white),
                          onPressed: controller.toggleSettings,
                        ),
                        Text(
                          '指放在屏幕2s',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.white),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(Icons.more_vert, color: Colors.white),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Main Content
                Positioned.fill(
                  top: 60,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(24),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '数字世界的守护者',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 24),
                          Text(
                            '在数字世界的深处，有一个名叫艾文的黑客。他不是那种为了金钱和利益而攻击网络的犯罪分子，而是一个有着高尚使命感的数字世界的守护者。',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              height: 1.6,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            '艾文的双手在键盘上飞舞，他的眼睛紧盯着屏幕上滚动的代码。他正在追踪一个名为"幽灵"的恶意软件，这个软件已经悄悄地侵入了数以千计的计算机系统，窃取敏感数据。',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              height: 1.6,
                            ),
                          ),
                          // Add more text content as needed
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Touch Indicator
                Obx(() => controller.showTouchIndicator.value
                  ? Positioned(
                      left: controller.touchPosition.value.dx - 25,
                      top: controller.touchPosition.value.dy - 25,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}