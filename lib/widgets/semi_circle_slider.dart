import 'dart:math' as math;

import 'package:cj_kit/logger/j_logger.dart';
import 'package:flutter/material.dart';

typedef VoidDoubleCallBack = void Function(double progress);

class SemiCircleSlider extends StatefulWidget {
  const SemiCircleSlider({
    Key? key,
    this.value = 0,
    this.radius = 150,
    this.thickness = 50,
    this.foreColor = const Color(0xffEF9918),
    this.backColor = const Color(0xffBBBBBB),
    this.sliderColor = Colors.white,
    this.onChange,
  }) : super(key: key);
  final double value;
  final double? radius;
  final double? thickness;
  final Color? foreColor;
  final Color? backColor;
  final Color? sliderColor;

  final VoidDoubleCallBack? onChange;

  @override
  SemiCircleSliderState createState() => SemiCircleSliderState();
}

class SemiCircleSliderState extends State<SemiCircleSlider> {
  double value = 0;

  @override
  void initState() {
    value = widget.value;
    super.initState();
    setValue(value);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.transparent,
        width: widget.radius! * 2,
        height: widget.radius! * 2,
        child: GestureDetector(
          onTapDown: (TapDownDetails details) {
            if (isPointInRing(details.localPosition)) {
              setState(() {
                setPosition(details.localPosition);
              });
            }
          },
          onPanUpdate: (DragUpdateDetails details) {
            if (isPointInRing(details.localPosition)) {
              setState(() {
                setPosition(details.localPosition);
              });
            }
          },
          child: RepaintBoundary(
            child: CustomPaint(
              painter: _SliderPainter(
                value: value,
                thickness: widget.thickness!,
                foreColor: widget.foreColor!,
                backColor: widget.backColor!,
                circleRadius: widget.radius!,
                sliderColor: widget.sliderColor!,
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isPointInRing(Offset position) {
    final double centerX = widget.radius!; // 圆环中心点的 x 坐标
    final double centerY = widget.radius!; // 圆环中心点的 y 坐标
    final double radius = widget.radius! - widget.thickness!; // 圆环半径

    final double dx = position.dx - centerX;
    final double dy = position.dy - centerY;
    final double distance = math.sqrt(dx * dx + dy * dy); // 计算手势点与圆环中心的距离
    JLogger.i("distance----$distance,$radius");
    if (distance >= radius && distance <= widget.radius! && isAngleInRange(dx, dy)) {
      return true;
    } else {
      return false;
    }
  }

  bool isAngleInRange(double dx, double dy) {
    final double angle = math.atan2(dy, dx); // 计算手势点与圆环中心连线的角度

    final double degrees = angle * 180 / math.pi;
    // 防止点击角度过小，加减5度
    if (degrees > 50 && degrees < 130) {
      return false;
    }
    return true;
  }

  // 计算滑块当前位置的角度
  void setPosition(Offset position) {
    double angle = math.atan2(
      position.dy - widget.radius!,
      position.dx - widget.radius!,
    );
    //弧度转为角度
    final double degrees = angle * 180 / math.pi;

    if (degrees <= 135 && degrees > 90) {
      angle = doubleToAngle(135);
    } else if (degrees >= 45 && degrees < 90) {
      angle = doubleToAngle(45);
    }

    // 将角度转换为0到1的范围
    value = angle / (2 * math.pi) + 0.5;

    // 当前进度
    double _progress = 0;
    if (value >= 0.875) {
      _progress = value - 0.875;
    } else if (value > 0 && value <= 0.625) {
      _progress = value + (1 - 0.875);
    }
    final double progress = _progress / (0.125 + 0.625) * 100;
    JLogger.i("当前进度为：$progress");
    JLogger.i("--value==2=$value,angle====$angle");
    widget.onChange?.call(progress);
  }

  void setValue(double _value) {
    final double t = _value * 0.75 / 100 - 0.125;
    setState(() {
      value = t;
    });
  }

  @override
  void didUpdateWidget(SemiCircleSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    value = widget.value;
  }

  double doubleToAngle(double angle) => angle * math.pi / 180.0;
}

class _SliderPainter extends CustomPainter {
  _SliderPainter({
    required this.value,
    required this.thickness,
    required this.foreColor,
    required this.backColor,
    required this.circleRadius,
    required this.sliderColor,
  });

  final double value;
  final double thickness;
  final Color foreColor;
  final Color backColor;
  final double circleRadius;
  final Color sliderColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = backColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round;
    final double canvasWidth = circleRadius * 2;
    final double centerX = canvasWidth / 2;
    final double centerY = canvasWidth / 2;
    final double radius = canvasWidth / 2 - paint.strokeWidth / 2;
    const double startAngle = math.pi * 0.75;
    const double endAngle = math.pi * 1.5;
    // 绘制底部的半圆形路径
    final Path backgroundPath = Path();
    backgroundPath.addArc(Rect.fromCircle(center: Offset(centerX, centerY), radius: radius), startAngle, endAngle);
    canvas.drawPath(backgroundPath, paint);

    final Paint thumbPaint = Paint()
      ..color = foreColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round;
    // 绘制橙色圆弧的位置
    final double adjustedAngle = (value - 0.5) * 2 * math.pi;

    double sweepAngle = adjustedAngle - startAngle;

    if (sweepAngle < 0) {
      sweepAngle += math.pi * 2;
      // startAngle -= math.pi * 2;
    }

    final Path arcPath = Path();
    arcPath.addArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      startAngle,
      sweepAngle,
    );
    canvas.drawPath(arcPath, thumbPaint);

    // 绘制滑块的位置
    final Paint sliderPaint = Paint()..color = sliderColor;
    final double thumbAngle = (value - 0.5) * 2 * math.pi;
    final double thumbX = centerX + math.cos(thumbAngle) * radius;
    final double thumbY = centerY + math.sin(thumbAngle) * radius;
    canvas.drawCircle(Offset(thumbX, thumbY), thickness / 2, sliderPaint);
  }

  @override
  bool? hitTest(Offset position) {
    // 例如，检查 position 是否在某个区域内
    //点击位置到圆心距离
    final double distance =
        math.sqrt(math.pow(circleRadius - position.dx, 2) + math.pow(circleRadius - position.dy, 2));
    return distance <= circleRadius && distance >= circleRadius - thickness;
  }

  @override
  bool shouldRepaint(_SliderPainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.thickness != thickness ||
        oldDelegate.foreColor != foreColor ||
        oldDelegate.backColor != backColor ||
        oldDelegate.circleRadius != circleRadius ||
        oldDelegate.sliderColor != sliderColor;
  }
}
