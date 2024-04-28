import 'dart:ui' as ui;

class ScreenAdapt {
  factory ScreenAdapt() => _instance;

  ScreenAdapt._() {
    final ui.PlatformDispatcher dispatcher = ui.PlatformDispatcher.instance;
    // 获取物理尺寸
    final ui.Size physicalSize = dispatcher.views.first.physicalSize;
    final double devicePixelRatio = dispatcher.views.first.devicePixelRatio;
    // 初始化分辨率
    physicalWidth = physicalSize.width;
    physicalHeight = physicalSize.height;
    // 屏幕宽高 (计算屏幕的逻辑尺寸)
    screenWidth = physicalWidth / devicePixelRatio;
    screenHeight = physicalHeight / devicePixelRatio;
    //这里是以iphone6 为模板来适配的
    dpr = screenWidth / 750; // 像素点适配
    px = screenWidth / 750 * 2; // 物理宽度适配
  }

  double physicalWidth = 0;
  double physicalHeight = 0;

  double screenWidth = 0;
  double screenHeight = 0;

  double dpr = 0;
  double px = 0;

  double statusBarHeight = 0;
  double bottomHeight = 0;

  static ScreenAdapt get instance => _instance;

  static final ScreenAdapt _instance = ScreenAdapt._();
}

extension SizeFit on double {
  double get dpx => this * ScreenAdapt.instance.dpr;

  double get px => this * ScreenAdapt.instance.px;
}
