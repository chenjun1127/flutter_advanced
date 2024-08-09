import 'package:biz_lib/biz_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced/utils/calc_utils.dart';
import 'package:flutter_advanced/utils/color_utils.dart';

///色彩条
class VerticalColorSlider extends StatefulWidget {
  VerticalColorSlider({
    super.key,
    double? width,
    double? height,
    double? sliderWidth,
    double? sliderHeight,
    List<Color>? colors,
    List<double>? stops,
    this.onChange,
    this.min = 0,
    this.max = 360,
    this.value = 50,
  })  : assert(colors?.length == stops?.length, 'Colors and stops must have the same length'),
        width = width ?? 13,
        height = height ?? 230,
        colors = colors ??
            <Color>[
              const Color(0xFFFC2F30),
              const Color(0xFFF234FE),
              const Color(0xFF2949FF),
              const Color(0xFF3FFEFE),
              const Color(0xFF00FF00),
              const Color(0xff40FE0D),
              const Color(0xFFFFFC33),
              const Color(0xFFFF1500)
            ],
        stops = stops ?? <double>[0, 0.18, 0.35, 0.5, 0.68, 0.72, 0.84, 1],
        sliderWidth = sliderWidth ?? 23,
        sliderHeight = sliderHeight ?? 8;
  final double width;
  final double height;
  final double sliderWidth;
  final double sliderHeight;

  final List<Color> colors;
  final List<double> stops;
  final double min;
  final double max;
  final double value;

  final void Function(double value, Color color, {required bool isDragging})? onChange;

  @override
  State<VerticalColorSlider> createState() => _VerticalColorSliderState();
}

class _VerticalColorSliderState extends State<VerticalColorSlider> {
  bool isDragging = false;

  double minY = 0;
  double maxY = 1;
  double _y = 0;

  double _getCurrentValue(double y) {
    final double height = widget.height;
    //得到value值，范围是0-1
    final double limitY = y.clamp(0, height);
    final double value = (height - limitY) / height;
    _y = 1 - value;
    // 将 0-1的 值映射到 0-360
    final double originalValue = getOriginValue(value).clamp(widget.min, widget.max);
    JLogger.i("计算值为:$value,映射后的值为:$originalValue");
    return originalValue;
  }

  double getOriginValue(double value) {
    final double originalValue = value * widget.max;
    return originalValue;
  }

  double get percent {
    final double percentValue = CalcUtils.mapValue(widget.value, widget.min, widget.max, minY, maxY);
    return percentValue;
  }

  double get percentHeight => (percent >= 0.5) ? (maxY - percent) * widget.height : percent * widget.height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (TapUpDetails details) {
        updateProgress(_getCurrentValue(details.localPosition.dy));
      },
      onVerticalDragStart: (DragStartDetails details) {
        isDragging = true;
        updateProgress(_getCurrentValue(details.localPosition.dy));
      },
      onVerticalDragUpdate: (DragUpdateDetails details) {
        updateProgress(_getCurrentValue(details.localPosition.dy));
      },
      onVerticalDragEnd: (DragEndDetails details) {
        isDragging = false;
        updateProgress(getOriginValue(percent));
      },
      child: Stack(
        children: <Widget>[
          Container(
            width: widget.width,
            height: widget.height,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
            child: _buildColorBg(),
          ),
          if (percent >= 0.5)
            PositionedDirectional(start: (widget.width-widget.sliderWidth)/2, top: percentHeight, child: _buildSlider())
          else
            PositionedDirectional(start: (widget.width-widget.sliderWidth)/2, bottom: percentHeight, child: _buildSlider())
        ],
      ),
    );
  }

  Widget _buildSlider() {
    return Container(
      width: widget.sliderWidth,
      height: widget.sliderHeight,
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(8))),
    );
  }

  void updateProgress(double progress) {
    final Color targetColor = ColorUtils.getColorFromGradient(_y, widget.colors, widget.stops);
    widget.onChange?.call(progress.clamp(widget.min, widget.max), targetColor, isDragging: isDragging);
  }

  Widget _buildColorBg() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: widget.colors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: widget.stops,
        ),
      ),
    );
  }
}
