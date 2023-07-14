import 'package:cj_kit/logger/j_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced/widgets/semi_circle_slider.dart';

class Demo13 extends StatefulWidget {
  const Demo13({super.key});

  @override
  State<Demo13> createState() => _Demo13State();
}

class _Demo13State extends State<Demo13> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Canvas绘制可拖动的环形进度条"),
      ),
      body: Container(
        color: Colors.red,
        child: SemiCircleSlider(
          onChange: (double value) {
            JLogger.i("--当前进度为:$value");
          },
        ),
      ),
    );
  }
}
