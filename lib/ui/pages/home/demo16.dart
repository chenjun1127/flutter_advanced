import 'package:flutter/material.dart';
import 'package:flutter_advanced/widgets/horizontal_slider.dart';
import 'package:flutter_advanced/widgets/vertical_brightness_slider.dart';
import 'package:flutter_advanced/widgets/vertical_color_slider.dart';

class Demo16 extends StatefulWidget {
  const Demo16({super.key});

  @override
  State<Demo16> createState() => _Demo16State();
}

class _Demo16State extends State<Demo16> {
  double currentValue = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("canvas 绘制进度条"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const HorizontalSlider(width: 300),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const VerticalBrightnessSlider(width: 50, height: 250, initialBrightness: 0.5),
                const SizedBox(width: 20),
                VerticalColorSlider(
                  value: currentValue,
                  width: 50,
                  height: 250,
                  onChange: (double value, Color color, {required bool isDragging}) {
                    setState(() {
                      currentValue = value;
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
