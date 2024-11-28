import 'package:biz_lib/biz_lib.dart';
import 'package:flutter/material.dart';

/// @author chenjun
/// @date 2024-07-10
/// @desc 仿iphone垂直滑动条
class VerticalBrightnessSlider extends StatefulWidget {
  const VerticalBrightnessSlider({
    required this.height,
    required this.width,
    required this.initialBrightness,
    super.key,
  });

  final double height;
  final double width;
  final double initialBrightness;

  @override
  State<VerticalBrightnessSlider> createState() => _VerticalBrightnessSliderState();
}

class _VerticalBrightnessSliderState extends State<VerticalBrightnessSlider> {
  _VerticalBrightnessSliderState() : _brightness = 0.5;
  double _brightness;

  @override
  void initState() {
    super.initState();
    _brightness = widget.initialBrightness;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (DragUpdateDetails details) {
        setState(() {
          _brightness = (_brightness - details.primaryDelta! / widget.height).clamp(0.0, 1.0);
        });
      },
      child: CustomPaint(
        size: Size(widget.width, widget.height),
        painter: _BrightnessSliderPainter(_brightness),
      ),
    );
  }
}

class _BrightnessSliderPainter extends CustomPainter {
  _BrightnessSliderPainter(this.brightness);

  final double brightness;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bgPaint = Paint()..color = Colors.red;
    final Paint indicatorPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[Colors.teal, Colors.white],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // 绘制背景渐变
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final double yPos = (1 - brightness) * size.height;
    JLogger.i('yPos:$yPos,brightness:$brightness,size.height:${size.height}');

    canvas.drawRect(
      Rect.fromLTWH(
        0,
        yPos,
        size.width,
        brightness * size.height,
      ),
      indicatorPaint,
    );
  }

  @override
  bool shouldRepaint(_BrightnessSliderPainter oldDelegate) {
    return oldDelegate.brightness != brightness;
  }
}
