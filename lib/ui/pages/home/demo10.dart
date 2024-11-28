import 'package:biz_lib/biz_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced/utils/calc_utils.dart';
import 'package:flutter_advanced/widgets/semi_circle_slider.dart';
import 'package:flutter_advanced/widgets/semi_circle_slider_2.dart';
import 'package:flutter_advanced/widgets/semi_circle_slider_3.dart';

class Demo10 extends StatefulWidget {
  const Demo10({super.key});

  static String title = 'Canvas绘制可拖动的环形进度条';
  static String routeName = 'demo10';

  @override
  State<Demo10> createState() => _Demo10State();
}

class _Demo10State extends State<Demo10> {
  double currentValue = 20;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        color: Colors.green,
        padding: const EdgeInsetsDirectional.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const SizedBox(height: 10),
            SemiCircleSlider(
              onChange: (double value) {
                JLogger.i('--当前进度为1:$value');
              },
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Text(
                '下面这个更完整，支持阿拉伯语从右边滑动',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            SemiCircleSlider2(
              value: 10,
              isRtl: Directionality.of(context) == TextDirection.rtl,
              onChange: (double progress, {bool value = false}) {
                JLogger.i('--当前进度为2:$progress,$value');
              },
            ),
            SemiCircleSlider3(
              value: currentValue,
              onChange: (double value, {bool isDragging = false}) {
                setState(() {
                  currentValue = CalcUtils.mapValueToRange(value);
                });
                JLogger.i('--当前进度为3:$value,isDragging:$isDragging');
              },
            ),
          ],
        ),
      ),
    );
  }
}
