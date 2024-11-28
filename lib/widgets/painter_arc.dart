import 'dart:math' as math;

import 'package:flutter/material.dart';

class PainterArc extends CustomPainter {
  PainterArc({
    required this.thickness,
    required this.startAngle,
    required this.sweepAngle,
    required this.colors,
    this.color = Colors.white,
    this.stops = const <double>[0, 1],
    this.radius = 0,
    this.defaultSweepAngle = 230,
    Color? bgColor,
  })  : bgColor = bgColor ?? const Color(0x1affffff),
        assert(colors.isNotEmpty, 'colors 不能为空'),
        assert(thickness > 0, 'thickness 必须大于 0'),
        assert(stops == null || colors.length == stops.length, 'stops 必须和 colors 长度相等');

  final List<Color> colors;
  final List<double>? stops;
  final double thickness;
  final Color bgColor;
  final double startAngle;
  final double sweepAngle;
  final double radius;
  final Color color;
  final double defaultSweepAngle;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final Rect rect = Rect.fromCircle(center: center, radius: size.width / 2);
    final double angleStart = toRadian(startAngle - 90);
    final double angleSweep = toRadian(sweepAngle);
    //起始角度为 0，结束角度为 1.5 * pi，这里的 pi 为 180 度（即 1.5708 rad）,GradientRotation 旋转角度让渐变从 0.75 * pi 开始，由于渐变颜色过渡有个裂开，这里剪掉 0.03 * pi 的部分，最终得到 0.72 * pi
    final SweepGradient gradient = SweepGradient(
      endAngle: angleSweep,
      colors: colors,
      transform: GradientRotation(angleStart * math.pi),
      stops: stops,
    );
    final Paint paint = Paint()
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    if (angleSweep > 0) {
      paint.shader = gradient.createShader(rect);
    }

    final Paint paintBg = Paint()
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke
      ..color = bgColor
      ..strokeCap = StrokeCap.round;

    final double radius = math.min(size.width / 2, size.height / 2) - thickness / 2;
    // 绘制背景
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      angleStart,
      toRadian(defaultSweepAngle),
      false,
      paintBg,
    );
    // 绘制进度
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), angleStart, angleSweep, false, paint);
    // 计算坐标绘制圆上点
    final double x = size.width / 2 + radius * math.cos(toRadian((sweepAngle + startAngle) - 90));
    final double y = size.height / 2 + radius * math.sin(toRadian((sweepAngle + startAngle) - 90));
    final Paint paintPointer = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(x, y), thickness / 2, paintPointer);
  }

  @override
  bool shouldRepaint(covariant PainterArc oldDelegate) {
    return thickness == oldDelegate.thickness || color != oldDelegate.color;
  }

  double toRadian(double degree) {
    return degree * math.pi / 180;
  }

  @override
  bool? hitTest(Offset position) {
    // 例如，检查 position 是否在某个区域内
    //点击位置到圆心距离
    final double d = math.sqrt(math.pow(radius - position.dx, 2) + math.pow(radius - position.dy, 2));

    final bool t = d >= 180 - 67 && d <= 180;
    // print("d----$d,radius----$radius,t====$t");
    return t;
  }
}
