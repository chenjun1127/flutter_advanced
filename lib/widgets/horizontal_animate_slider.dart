import 'package:flutter/material.dart';

/// @author chenjun
/// @date 2024-07-10
/// @desc 带动画的横向滑竿滑动条
class HorizontalAnimateSlider extends StatefulWidget {
  const HorizontalAnimateSlider({
    this.width = 200,
    this.height = 40,
    this.value = 0.5,
    this.sliderHeight = 8,
    this.sliderBorderRadius = 15,
    this.bgColor = Colors.white12,
    this.foreColor = Colors.white,
    this.pointSize = 20,
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
  _HorizontalAnimateSliderState createState() => _HorizontalAnimateSliderState();
}

class _HorizontalAnimateSliderState extends State<HorizontalAnimateSlider> with SingleTickerProviderStateMixin {
  double _value = 0.5; // 初始值为50%
  bool _isDragging = false; // 是否正在拖动
  TextDirection? textDirection;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {
          _value = _animation.value;
        });
      });
    _animation = Tween<double>(begin: _value, end: _value).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateValue(double dx, {bool animate = false, bool callOnChange = true}) {
    double newValue;
    if (isRtl) {
      newValue = ((widget.width - dx) / widget.width).clamp(0.0, 1.0);
    } else {
      newValue = (dx / widget.width).clamp(0.0, 1.0);
    }

    if (newValue < 0.005) {
      newValue = 0;
    }

    if (animate) {
      _animateToValue(newValue);
    } else {
      setState(() {
        _value = double.parse(newValue.toStringAsFixed(2));
      });
      if (callOnChange) {
        widget.onChange?.call(_value, isDragging: _isDragging);
      }
    }
  }

  void _animateToValue(double newValue) {
    _animation = Tween<double>(begin: _value, end: newValue).animate(_controller);
    _controller.forward(from: 0).then((_) {
      widget.onChange?.call(_value, isDragging: _isDragging);
    });
  }

  bool get isRtl => textDirection == TextDirection.rtl;

  @override
  Widget build(BuildContext context) {
    textDirection = Directionality.of(context);
    return GestureDetector(
      onHorizontalDragStart: (DragStartDetails details) {
        final double dragStartX = isRtl ? (1 - _value) * widget.width : _value * widget.width;
        if ((details.localPosition.dx - dragStartX).abs() <= widget.pointSize * 2.5) {
          setState(() {
            _isDragging = true;
          });
          widget.onChange?.call(_value, isDragging: _isDragging);
        }
      },
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        if (_isDragging) {
          _updateValue(details.localPosition.dx, callOnChange: false);
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
        _updateValue(details.localPosition.dx, animate: true, callOnChange: false);
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
              child: AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget? child) {
                  return Container(
                    width: _value * widget.width,
                    height: widget.sliderHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(isRtl ? 0 : widget.sliderBorderRadius),
                        right: Radius.circular(!isRtl ? 0 : widget.sliderBorderRadius),
                      ),
                      color: widget.foreColor,
                    ),
                  );
                },
              ),
            ),
            // 圆形滑块
            PositionedDirectional(
              start: _value * (widget.width - widget.pointSize),
              child: Container(
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
  void didUpdateWidget(HorizontalAnimateSlider oldWidget) {
    if (oldWidget.value != widget.value) {
      setState(() {
        _value = widget.value;
      });
    }
    super.didUpdateWidget(oldWidget);
  }
}
