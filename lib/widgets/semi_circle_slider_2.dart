import 'dart:math' as math;

import 'package:flutter/material.dart';

typedef VoidDoubleCallBack = void Function(double progress, {bool value});

class SemiCircleSlider2 extends StatefulWidget {
  const SemiCircleSlider2({
    super.key,
    this.value = 0,
    this.percent = 0,
    this.width = 300,
    this.height = 300,
    this.radius = 150,
    this.thickness = 50,
    this.onChange,
    this.isRtl = false,
  });
  final double value;
  final double percent;
  final double? width;
  final double? height;
  final double? radius;
  final double? thickness;
  final VoidDoubleCallBack? onChange;
  final bool isRtl;
  @override
  State<SemiCircleSlider2> createState() => _SemiCircleSlider2State();
}

class _SemiCircleSlider2State extends State<SemiCircleSlider2> {
  double value = 0;
  double percent = 0;
  bool isDragging = false;
  double currentValue = 0;

  @override
  void initState() {
    value = widget.value;
    setValue(value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Container(
            width: widget.width,
            alignment: AlignmentDirectional.topCenter,
            height: widget.height,
            child: SizedBox(
              width: widget.width,
              height: widget.height,
              child: GestureDetector(
                onVerticalDragDown: (DragDownDetails details) {
                  // if (isPointInRing(details.localPosition)) {
                  //   setState(() {
                  //     setPosition(details.localPosition);
                  //   });
                  // }
                },
                onVerticalDragStart: (DragStartDetails details) {
                  if (isPointInRing(details.localPosition)) {
                    setState(() {
                      setPosition(details.localPosition);
                      isDragging = true;
                      widget.onChange?.call(currentValue, value: isDragging);
                    });
                  }
                },
                onVerticalDragUpdate: (DragUpdateDetails details) {
                  if (isPointInRing(details.localPosition)) {
                    setState(() {
                      setPosition(details.localPosition);
                      widget.onChange?.call(currentValue, value: isDragging);
                    });
                  }
                },
                onVerticalDragEnd: (DragEndDetails details) {
                  setState(() {
                    isDragging = false;
                  });
                  widget.onChange?.call(currentValue, value: isDragging);
                },
                onVerticalDragCancel: () {
                  if (isDragging) {
                    setState(() {
                      isDragging = false;
                    });
                  }
                },
                onHorizontalDragDown: (DragDownDetails details) {
                  // if (isPointInRing(details.localPosition)) {
                  //   setState(() {
                  //     setPosition(details.localPosition);
                  //   });
                  // }
                },
                onHorizontalDragStart: (DragStartDetails details) {
                  if (isPointInRing(details.localPosition)) {
                    setState(() {
                      isDragging = true;
                      setPosition(details.localPosition);
                      widget.onChange?.call(currentValue, value: isDragging);
                    });
                  }
                },
                onHorizontalDragUpdate: (DragUpdateDetails details) {
                  if (isPointInRing(details.localPosition)) {
                    setState(() {
                      setPosition(details.localPosition);
                      widget.onChange?.call(currentValue, value: isDragging);
                    });
                  }
                },
                onHorizontalDragEnd: (DragEndDetails d) {
                  setState(() {
                    isDragging = false;
                  });
                  widget.onChange?.call(currentValue, value: isDragging);
                },
                onHorizontalDragCancel: () {
                  if (isDragging) {
                    setState(() {
                      isDragging = false;
                    });
                  }
                },
                child: RepaintBoundary(
                  child: CustomPaint(
                    painter: MCustomPainter(
                      isRtl: widget.isRtl,
                      value: currentValue,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            child: Text(
              '${currentValue.toInt()}%',
              style: const TextStyle(fontSize: 32, color: Colors.black87),
            ),
          )
        ],
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
    // print("distance----$distance,$radius,${widget.radius},${isAngleInRange(dx, dy)}");
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
    if (degrees > 55 && degrees < 125) {
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
      angle = _toRadius(135);
    } else if (degrees >= 45 && degrees < 90) {
      angle = _toRadius(45);
    }

    // 将角度转换为0到1的范围
    value = widget.isRtl ? 0.5 - angle / (2 * math.pi) + 0.5 : angle / (2 * math.pi) + 0.5;
    // 当前进度
    double currentProgress = 0;
    if (value >= 0.875) {
      currentProgress = value - 0.875;
    } else if (value > 0 && value <= 0.625) {
      currentProgress = value + (1 - 0.875);
    }
    final double progress = currentProgress / (0.125 + 0.625) * 100;
    // print("--value==2=$value,angle====$progress");
    currentValue = progress;
    setValue(currentValue);
  }

  void setValue(double v) {
    final double t = v * 0.75 / 100 - 0.125;
    setState(() {
      value = widget.isRtl ? 0.5 - t : t;
      percent = v;
    });
  }

  @override
  void didUpdateWidget(SemiCircleSlider2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    value = widget.value;
    setValue(value);
  }

  double _toRadius(num degree) => degree * math.pi / 180;
}

class MCustomPainter extends CustomPainter {
  MCustomPainter({required this.value, required this.isRtl});
  final double value;
  final bool isRtl;
  @override
  void paint(Canvas canvas, Size size) {
    _draw(canvas, size);
  }

  final Paint _paint = Paint();

  @override
  bool shouldRepaint(MCustomPainter oldDelegate) {
    return oldDelegate.value != value || oldDelegate.isRtl != isRtl;
  }

  int max = 100;
  int min = 0;

  void _draw(Canvas canvas, Size size) {
    final Offset offset = Offset(size.width / 2, size.width / 2);
    const double strokeWidth = 50;
    const double radius = 125;
    const int startAngle = 135;
    const int endAngle = 270;
    _paint
      ..isAntiAlias = true
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final Path backgroundPath = Path();
    backgroundPath.addArc(Rect.fromCircle(center: offset, radius: radius), _toRadius(startAngle), _toRadius(endAngle));
    canvas.drawPath(backgroundPath, _paint);

    _paint
      ..color = Colors.cyan
      ..strokeWidth = strokeWidth;
    final Path backgroundPath1 = Path();
    if (!isRtl) {
      backgroundPath1.addArc(Rect.fromCircle(center: offset, radius: radius), _toRadius(startAngle),
          value * _toRadius(endAngle / (max - min)));
    } else {
      backgroundPath1.addArc(Rect.fromCircle(center: offset, radius: radius), _toRadius(startAngle + endAngle),
          value * _toRadius(-endAngle / (max - min)));
    }

    ///在 Flutter 中，默认情况下，addArc 方法是按照顺时针方向绘制弧形的。如果你希望反转方向，即逆时针绘制弧形，可以调整 startAngle 和 sweepAngle 参数。
    ///在你的具体情况中，将 _toRadius(135) 改为 _toRadius(405)，将 _toRadius(270) 改为 _toRadius(-270)，即可实现逆时针绘制弧形。
    canvas.drawPath(backgroundPath1, _paint);

    final double t = value * 0.75 / 100 - 0.125;

    final double v = isRtl ? 0.5 - t : t;

    // 绘制滑块的位置
    final Paint sliderPaint = Paint()..color = Colors.white;
    final double thumbAngle = (v - 0.5) * 2 * math.pi;
    final double thumbX = size.width / 2 + math.cos(thumbAngle) * radius;
    final double thumbY = size.height / 2 + math.sin(thumbAngle) * radius;
    canvas.drawCircle(Offset(thumbX, thumbY), strokeWidth / 2, sliderPaint);
  }

  double _toRadius(num degree) => degree * math.pi / 180;
}
