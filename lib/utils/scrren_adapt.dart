import 'dart:ui';

class ScreenAdapt {
  factory ScreenAdapt() => _getInstance();

  ScreenAdapt._() {
    // 初始化分辨率
    physicalWidth = window.physicalSize.width;
    physicalHeight = window.physicalSize.height;
    // 屏幕宽高
    screenWidth = physicalWidth / window.devicePixelRatio;
    screenHeight = physicalHeight / window.devicePixelRatio;
    //这里是以iphone6 为模板来适配的
    dpr = screenWidth / 750; // 像素点适配
    px = screenWidth / 750 * 2; // 物理宽度适配
    //导航栏和底部工具栏的高度
    statusBarHeight = window.padding.top;
    bottomHeight = window.padding.bottom;
  }

  double physicalWidth = 0;
  double physicalHeight = 0;

  double screenWidth = 0;
  double screenHeight = 0;

  double dpr = 0;
  double px = 0;

  double statusBarHeight = 0;
  double bottomHeight = 0;

  static ScreenAdapt? _instance;
  static ScreenAdapt get instance => _getInstance();
  //获取对象
  static ScreenAdapt _getInstance() {
    _instance ??= ScreenAdapt._();
    return _instance!;
  }
}

extension SizeFit on double {
  double get dpx => this * ScreenAdapt.instance.dpr;

  double get px => this * ScreenAdapt.instance.px;
}
