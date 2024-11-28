import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_advanced/widgets/base_container.dart';

class Demo6 extends StatefulWidget {
  const Demo6({super.key});
  static String routeName = 'demo6';
  static String title = 'CustomPainter';

  @override
  State<Demo6> createState() => _Demo6State();
}

class _Demo6State extends State<Demo6> {
  double radius = 100;

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            color: Colors.teal,
            height: MediaQuery.of(context).size.height,
            //点击刷新时避免重绘
            child: RepaintBoundary(
              child: CustomPaint(
                painter: MyPainter(radius: radius),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: SizedBox(
              height: 50,
              width: 160,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.blue),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                ),
                onPressed: () {
                  setState(() {
                    radius = radius >= 150 ? 100 : radius += 10;
                  });
                },
                child: const Text('点击改变radius'),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  MyPainter({this.radius = 100});

  final double? radius;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    drawBg(canvas, rect);
    drawCircle(canvas, rect);
  }

  @override
  bool shouldRepaint(covariant MyPainter oldDelegate) {
    return oldDelegate.radius != radius;
  }

  void drawBg(Canvas canvas, Rect rect) {
    final Paint paintBg = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(Offset(rect.width / 2, rect.height / 2), radius!, paintBg);
  }

  void drawCircle(Canvas canvas, Rect rect) {
    final Paint paintCircle = Paint()..color = Colors.orange;
    for (int i = 0; i < 360; i += 30) {
      final double x = cos(pi / 180 * i) * radius!;
      final double y = sin(pi / 180 * i) * radius!;
      canvas.drawCircle(Offset(x + rect.width / 2, y + rect.height / 2), 10, paintCircle);
      canvas.drawLine(
        Offset(rect.width / 2, rect.height / 2),
        Offset(x + rect.width / 2, y + rect.height / 2),
        paintCircle,
      );
    }
  }
}
