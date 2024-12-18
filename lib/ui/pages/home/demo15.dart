import 'dart:math' as math;

import 'package:flutter/material.dart';

class Demo15 extends StatelessWidget {
  const Demo15({super.key});

  static String title = 'Canvas 绘制带渐变的圆形进度条';
  static String routeName = 'demo15';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        width: 1000,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircularGradientBar(),
            CircularProgressBar(
              progress: 0.6,
            ),
          ],
        ),
      ),
    );
  }
}

class CircularGradientBar extends StatelessWidget {
  const CircularGradientBar({
    this.strokeWidth = 8.0,
    super.key,
    this.color = Colors.blue,
  });

  final double strokeWidth;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CircularGradientPainter(
        strokeWidth: strokeWidth,
        color: color,
      ),
      size: const Size.square(300),
    );
  }
}

class _CircularGradientPainter extends CustomPainter {
  _CircularGradientPainter({
    required this.strokeWidth,
    required this.color,
  });

  final double strokeWidth;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final Rect rect = Rect.fromCircle(
      center: center,
      radius: size.width / 2,
    );
    //起始角度为 0，结束角度为 1.5 * pi，这里的 pi 为 180 度（即 1.5708 rad）,GradientRotation 旋转角度让渐变从 0.75 * pi 开始，由于渐变颜色过渡有个裂开，这里剪掉 0.03 * pi 的部分，最终得到 0.72 * pi
    const SweepGradient gradient = SweepGradient(
      endAngle: 1.5 * math.pi,
      colors: <Color>[Colors.red, Colors.green],
      transform: GradientRotation(0.72 * math.pi),
      stops: <double>[0, 1],
    );
    final Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round;

    // Draw the arc

    final double radius = math.min(size.width / 2, size.height / 2) - strokeWidth / 2;
    const double startAngle = 0.75 * math.pi;
    const double sweepAngle = 1.5 * math.pi;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircularGradientPainter oldDelegate) {
    return strokeWidth == oldDelegate.strokeWidth || color != oldDelegate.color;
  }
}

class CircularProgressBar extends StatelessWidget {
  const CircularProgressBar({
    required this.progress,
    this.strokeWidth = 8.0,
    this.color = Colors.blue,
    super.key,
  })  : assert(progress >= 0 && progress <= 1, 'Progress should be a value between 0 and 1');
  final double progress;
  final double strokeWidth;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CircularProgressPainter(
        progress: progress,
        strokeWidth: strokeWidth,
        color: color,
      ),
      size: const Size.square(300),
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  _CircularProgressPainter({required this.progress, required this.strokeWidth, required this.color});

  final double progress;
  final double strokeWidth;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw the arc
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = math.min(size.width / 2, size.height / 2) - strokeWidth / 2;
    const double startAngle = -math.pi / 2;
    final double sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircularProgressPainter oldDelegate) {
    return progress != oldDelegate.progress || strokeWidth != oldDelegate.strokeWidth || color != oldDelegate.color;
  }
}
