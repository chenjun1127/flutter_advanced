import 'package:flutter/material.dart';

/// @author chenjun
/// @date 2024-07-10
/// @desc 仿IOS横向滑竿滑动条

class HorizontalSlider extends StatefulWidget {
  const HorizontalSlider({
    this.width = 200,
    this.height = 40,
    this.value = 0.5,
    this.sliderHeight = 8,
    this.sliderBorderRadius = 15,
    this.bgColor = Colors.black12,
    this.foreColor = Colors.blue,
    this.pointSize = 30,
    this.pointColor = Colors.white,
    this.onChange,
    super.key,
  });

  final double width;
  final double height;
  final double sliderHeight;
  final double sliderBorderRadius;
  final double value;
  final Color bgColor;
  final Color foreColor;
  final double pointSize;
  final Color pointColor;
  final void Function(double value, {required bool isDragging})? onChange;

  @override
  _HorizontalSliderState createState() => _HorizontalSliderState();
}

class _HorizontalSliderState extends State<HorizontalSlider> {
  double _value = 0.5; // 初始值为50%
  bool _isDragging = false; // 是否正在拖动
  TextDirection? textDirection;
  bool _isIncreasing = true; // 记录拖动方向
  @override
  void initState() {
    _value = widget.value;
    super.initState();
  }

  void _updateValue(double dx) {
    setState(() {
      if (isRtl) {
        final double newValue = ((widget.width - dx) / widget.width).clamp(0.0, 1.0);
        _isIncreasing = newValue > _value;
        _value = newValue;
      } else {
        final double newValue = (dx / widget.width).clamp(0.0, 1.0);
        _isIncreasing = newValue > _value;
        _value = newValue;
      }

      if (_value < 0.005) {
        _value = 0;
      }
    });
  }

  bool get isRtl => textDirection == TextDirection.rtl;

  @override
  Widget build(BuildContext context) {
    textDirection = Directionality.of(context);
    return GestureDetector(
      onHorizontalDragStart: (DragStartDetails details) {
        // 检查是否触摸在圆形滑块上
        final double dragStartX = isRtl ? (1 - _value) * widget.width : _value * widget.width;
        if ((details.localPosition.dx - dragStartX).abs() <= widget.pointSize) {
          setState(() {
            _isDragging = true;
          });
          widget.onChange?.call(_value, isDragging: _isDragging);
        }
      },
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        if (_isDragging) {
          // 根据手指的移动更新滑块的位置
          _updateValue(details.localPosition.dx);
          widget.onChange?.call(_value, isDragging: _isDragging);
        }
      },
      onHorizontalDragEnd: (DragEndDetails details) {
        if (_isDragging) {
          setState(() {
            _isDragging = false;
          });
          widget.onChange?.call(_value, isDragging: _isDragging);
        }
      },
      onTapUp: (TapUpDetails details) {
        // 点击时设置滑块位置
        _updateValue(details.localPosition.dx);
        widget.onChange?.call(_value, isDragging: _isDragging);
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        color: Colors.transparent,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            // 背景滑轨
            Container(
              width: widget.width,
              height: widget.sliderHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.sliderBorderRadius),
                color: widget.bgColor,
              ),
            ),
            // 前景色条
            PositionedDirectional(
              start: 0,
              child: AnimatedContainer(
                duration: _isIncreasing ? const Duration(milliseconds: 100) : Duration.zero,
                width: _value * widget.width,
                height: widget.sliderHeight,
                transformAlignment: AlignmentDirectional.centerEnd,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(isRtl ? 0 : widget.sliderBorderRadius),
                    right: Radius.circular(!isRtl ? 0 : widget.sliderBorderRadius),
                  ),
                  color: widget.foreColor,
                ),
              ),
            ),
            // 圆形滑块
            PositionedDirectional(
              start: _value * (widget.width - widget.pointSize),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                width: widget.pointSize,
                height: widget.pointSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.pointColor,
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(HorizontalSlider oldWidget) {
    if (oldWidget.value != widget.value) {
      setState(() {
        _value = widget.value;
      });
    }
    super.didUpdateWidget(oldWidget);
  }
}
