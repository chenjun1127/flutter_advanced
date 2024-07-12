import 'dart:math' as math;

import 'package:flutter/material.dart';

class Demo17 extends StatefulWidget {
  const Demo17({super.key});

  @override
  State<Demo17> createState() => _Demo17State();
}

class _Demo17State extends State<Demo17> {
  TextStyle textStyle = const TextStyle(
    fontSize: 20,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("弧形文字"),
      ),
      body: Center(
        child: CustomPaint(
          size: const Size(400, 400),
          painter: ArcTextPainter(
            getVisibleText("我们一起来学习Flutter", textStyle, 220),
            textStyle: textStyle,
            startAngle: math.pi * 135 / 180,
            sweepAngle: math.pi * 270 / 180,
          ),
        ),
      ),
    );
  }

  String getVisibleText(String text, TextStyle textStyle, double maxWidth) {
    final TextSpan textSpan = TextSpan(text: text, style: textStyle);
    final TextPainter textPainter = TextPainter(
      text: textSpan,
      maxLines: 1,
      textDirection: Directionality.of(context),
      textAlign: TextAlign.left,
    );

    textPainter.layout(maxWidth: maxWidth);

    final int index = textPainter.getPositionForOffset(Offset(maxWidth, 0)).offset;
    final String newText = text.substring(0, index);
    if (newText.length < text.length) {
      return '$newText...';
    }
    return text;
  }
}

class ArcTextPainter extends CustomPainter {
  ArcTextPainter(
    this.text, {
    this.radius = 100.0,
    this.startAngle = 0.0,
    this.sweepAngle = 2 * math.pi,
    this.textStyle = const TextStyle(fontSize: 20),
  });

  final String text;
  final double radius;
  final double startAngle; // 起始角度
  final double sweepAngle; // 扫描角度
  final TextStyle textStyle;

  @override
  void paint(Canvas canvas, Size size) {
    final double anglePerChar = sweepAngle / (text.length - 1); // 每个字符占用的角度

    // 计算中心点
    final Offset center = Offset(size.width / 2, size.height / 2);

    for (int i = 0; i < text.length; i++) {
      final String char = text[i];
      final double angle = startAngle + anglePerChar * i; // 角度偏移量

      // 计算字符位置
      final double x = center.dx + radius * math.cos(angle);
      final double y = center.dy + radius * math.sin(angle);

      // 保存当前画布状态
      canvas.save();

      // 平移并旋转画布
      canvas.translate(x, y);
      canvas.rotate(angle + math.pi / 2);

      // 绘制字符
      final TextPainter textPainter = TextPainter(
        text: TextSpan(text: char, style: textStyle),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));

      // 恢复画布状态
      canvas.restore();

      final Paint paint = Paint();
      paint.style = PaintingStyle.stroke;
      paint.color = Colors.black;
      paint.strokeCap = StrokeCap.round;
      paint.strokeWidth = 2;
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius + 20), startAngle, sweepAngle, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant ArcTextPainter oldDelegate) {
    return oldDelegate.radius != radius || oldDelegate.text != text;
  }
}
