import 'dart:math' as math;

import 'package:biz_lib/biz_lib.dart';
import 'package:flutter/material.dart';

class Demo18 extends StatefulWidget {
  const Demo18({super.key});

  static String title = '自定义滚动条一';
  static String routeName = 'demo18';

  @override
  State<Demo18> createState() => _Demo18State();
}

class _Demo18State extends State<Demo18> {
  final ScrollController _scrollController = ScrollController();
  double _progress = 0;
  double _fractionOfThumb = 0;
  double _index = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateScrollValue);
  }

  ///两种方法这种方法更精准
  void _updateScrollValue() {
    if (_scrollController.hasClients) {
      _fractionOfThumb =
          1 / ((_scrollController.position.maxScrollExtent / _scrollController.position.viewportDimension) + 1);
      _index = _scrollController.offset / _scrollController.position.viewportDimension;

      setState(() {
        _progress = _scrollController.offset / _scrollController.position.maxScrollExtent;
      });
      JLogger.i("fractionOfThumb:$_fractionOfThumb index:$_index progress:$_progress");
    }
  }

  // void _updateScrollValue2() {
  //   setState(() {
  //     final double maxScrollExtent = _scrollController.position.maxScrollExtent;
  //     final double offset = _scrollController.offset;
  //     if (offset < 0) {
  //       _progress = 0;
  //     } else if (offset > maxScrollExtent) {
  //       _progress = 1;
  //     } else {
  //       _progress = offset / maxScrollExtent;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(title: Text("$index"));
          },
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          itemCount: 100,
        ),
        Positioned(
          right: 20,
          top: MediaQuery.of(context).size.height / 2 - 25,
          child: CustomPaint(
            painter: CircularScrollProgressPainter(_progress),
            child: const SizedBox(width: 50, height: 50),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateScrollValue);
    _scrollController.dispose();
    super.dispose();
  }
}

class CircularScrollProgressPainter extends CustomPainter {
  CircularScrollProgressPainter(this.progress);

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    final double radius = size.width / 2;
    final Offset center = Offset(radius, radius);
    canvas.drawCircle(center, radius, paint);

    final Paint progressPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final double sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -math.pi / 2, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CircularScrollProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
