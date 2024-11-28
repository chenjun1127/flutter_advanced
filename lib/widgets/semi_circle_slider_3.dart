import 'dart:math' as math;

import 'package:biz_lib/biz_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced/utils/calc_utils.dart';
import 'package:flutter_advanced/widgets/painter_arc.dart';

/// Created by chenjun on 2024/4/25.
/// @desc: 弧形进度条
/// @author chenjun
/// @date: 2024/4/25
typedef VoidDoubleCallBack = void Function(double progress, {bool isDragging});

class SemiCircleSlider3 extends StatefulWidget {
  const SemiCircleSlider3({
    required this.value,
    super.key,
    this.thickness = 17,
    this.max = 100,
    this.min = 0,
    this.gradientColors = const <Color>[Color(0xFF1C1D20), Color(0xFFFFB162)],
    this.pointSize = 22,
    this.textColors,
    this.textStops,
    this.textUnit = '%',
    this.radius = 180,
    this.onChange,
  });

  final double thickness;
  final double value;
  final double min;
  final double max;
  final List<Color> gradientColors;
  final double pointSize;
  final List<Color>? textColors;
  final List<double>? textStops;
  final String textUnit;
  final double radius;
  final VoidDoubleCallBack? onChange;

  @override
  State<SemiCircleSlider3> createState() => _SemiCircleSlider3State();
}

class _SemiCircleSlider3State extends State<SemiCircleSlider3> {
  double get startAngle => 155;

  double get arcAngle => 230;
  bool isDragging = false;

  bool isCanDrag = true;
  double currentAngle = 0;

  @override
  Widget build(BuildContext context) {
    final double value = widget.value;
    final double calcValue = CalcUtils.mapValue(value, widget.min, widget.max, widget.min, arcAngle);
    final double calcProgress = CalcUtils.mapValue(value, widget.min, widget.max, startAngle, startAngle + arcAngle);
    // final double t = calcProgress > 360 ? calcProgress - 360 : calcProgress;
    JLogger.i('亮度映射角度：$calcValue,亮度映射进度：$calcProgress:$value');
    return GestureDetector(
      onVerticalDragDown: (DragDownDetails details) {
        setState(() {
          isCanDrag = isPointInRing(details.localPosition);
        });
        if (isPointInRing(details.localPosition)) {
          setState(() {
            setPosition(details.localPosition);
          });
        }
      },
      onVerticalDragStart: (DragStartDetails details) {
        if (isPointInRing(details.localPosition)) {
          setState(() {
            setPosition(details.localPosition);
            isDragging = true;
          });
        }
      },
      onVerticalDragUpdate: (DragUpdateDetails details) {
        if (isPointInRing(details.localPosition) && isCanDrag) {
          setState(() {
            setPosition(details.localPosition);
          });
        }
      },
      onVerticalDragEnd: (DragEndDetails details) {
        setState(() {
          isDragging = false;
        });
      },
      onVerticalDragCancel: () {
        if (isDragging) {
          setState(() {
            isDragging = false;
          });
        }
      },
      onHorizontalDragDown: (DragDownDetails details) {
        setState(() {
          isCanDrag = isPointInRing(details.localPosition);
        });
        if (isPointInRing(details.localPosition)) {
          setState(() {
            setPosition(details.localPosition);
          });
        }
      },
      onHorizontalDragStart: (DragStartDetails details) {
        if (isPointInRing(details.localPosition)) {
          setState(() {
            isDragging = true;
            setPosition(details.localPosition);
          });
        }
      },
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        if (isPointInRing(details.localPosition) && isCanDrag) {
          setState(() {
            setPosition(details.localPosition);
          });
        }
      },
      onHorizontalDragEnd: (DragEndDetails d) {
        setState(() {
          isDragging = false;
        });
      },
      onHorizontalDragCancel: () {
        if (isDragging) {
          setState(() {
            isDragging = false;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        child: CustomPaint(
          size: const Size(320, 320),
          painter: PainterArc(
            thickness: 17,
            startAngle: 245,
            radius: 320 / 2,
            sweepAngle: calcValue,
            colors: <Color>[
              const Color(0xff1C1D20),
              const Color(0xff696D79),
            ],
          ),
        ),
      ),
    );
  }

  bool isPointInRing(Offset position) {
    final double centerX = widget.radius; // 圆环中心点的 x 坐标
    final double centerY = widget.radius; // 圆环中心点的 y 坐标
    final double radius = widget.radius - widget.thickness - 20 - 30; // 圆环半径

    final double dx = position.dx - centerX;
    final double dy = position.dy - centerY;
    final double distance = math.sqrt(dx * dx + dy * dy); // 计算手势点与圆环中心的距离
    // print("distance----$distance,$radius,${widget.radius},${isAngleInRange(dx, dy)}");
    if (distance >= radius && isAngleInRange(dx, dy)) {
      return true;
    } else {
      return false;
    }
  }

  bool isAngleInRange(double dx, double dy) {
    final double angle = math.atan2(dy, dx); // 计算手势点与圆环中心连线的角度
    final double degrees = angle * 180 / math.pi;
    // 防止点击角度过小，加减1度
    if (degrees > 26 && degrees < 156) {
      return false;
    }
    return true;
  }

  void setPosition(Offset position) {
    final double angle = math.atan2(position.dy - widget.radius, position.dx - widget.radius); // 计算手势点与圆环中心连线的角度
    double degrees = angle * 180 / math.pi;
    if (degrees < 0) {
      degrees = 360 + degrees;
    }
    setState(() {
      currentAngle = degrees + 90;
    });
    widget.onChange?.call(currentAngle, isDragging: isDragging);
  }
}
