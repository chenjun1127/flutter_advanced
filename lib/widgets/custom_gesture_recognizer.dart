import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomTapGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    //不，我不要失败，我要成功
    //super.rejectGesture(pointer);
    //宣布成功
    super.acceptGesture(pointer);
  }
}

//创建一个新的GestureDetector，用我们自定义的 CustomTapGestureRecognizer 替换默认的
RawGestureDetector customGestureDetector({
  GestureTapCallback? onTap,
  GestureTapDownCallback? onTapDown,
  Widget? child,
}) {
  return RawGestureDetector(
    gestures: <Type, GestureRecognizerFactory>{
      CustomTapGestureRecognizer: GestureRecognizerFactoryWithHandlers<CustomTapGestureRecognizer>(
        CustomTapGestureRecognizer.new,
        (CustomTapGestureRecognizer detector) {
          detector.onTap = onTap;
        },
      )
    },
    child: child,
  );
}
