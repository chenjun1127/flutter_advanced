import 'package:biz_lib/biz_lib.dart';
import 'package:flutter/material.dart';

class CustomScrollBar extends StatefulWidget {
  const CustomScrollBar({required this.builder, super.key, this.scrollController});

  final Widget Function(BuildContext context, ScrollController scrollController) builder;
  final ScrollController? scrollController;

  @override
  State<CustomScrollBar> createState() => _CustomScrollBarState();
}

class _CustomScrollBarState extends State<CustomScrollBar> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = widget.scrollController ?? ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.builder(context, _scrollController),
        _BuildScrollBar(scrollController: _scrollController),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class _BuildScrollBar extends StatefulWidget {
  const _BuildScrollBar({required this.scrollController, Duration? duration})
      : duration = duration ?? const Duration(milliseconds: 200);
  final ScrollController scrollController;
  final Duration duration;

  @override
  State<_BuildScrollBar> createState() => _BuildScrollBarState();
}

class _BuildScrollBarState extends State<_BuildScrollBar> {
  double _progress = 0;
  double _fractionOfThumb = 0;
  double _index = 0;

  ScrollController get _scrollController => widget.scrollController;
  bool _isScrollBarVisible = false;
  int _currentHideUpdate = 0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScrolled);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateScrollValue();
      _hideAfterDelay();
    });
  }

  void _onScrolled() {
    if (!_scrollController.hasClients) {
      return;
    }

    setState(() {
      _isScrollBarVisible = true;
      _updateScrollValue();
    });

    _hideAfterDelay();
  }

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

  void _hideAfterDelay() {
    _currentHideUpdate++;
    final int thisUpdate = _currentHideUpdate;
    Future<void>.delayed(
      widget.duration,
      () {
        if (thisUpdate != _currentHideUpdate) {
          return;
        }

        if (mounted) {
          setState(() {
            _isScrollBarVisible = false;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        if (widget.scrollController.hasClients)
          AnimatedOpacity(
            duration: const Duration(microseconds: 300),
            opacity: _isScrollBarVisible ? 1 : 0,
            child: Align(
              alignment: Alignment.centerRight,
              child: CustomPaint(
                painter: _ScrollBarPainter(
                  progress: _progress,
                  fractionOfThumb: _fractionOfThumb,
                  index: _index,
                  thumbWidth: 10,
                ),
                child: SizedBox(width: 10, height: MediaQuery.of(context).size.height),
              ),
            ),
          )
        else
          const SizedBox(),
      ],
    );
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScrolled);
    super.dispose();
  }
}

class _ScrollBarPainter extends CustomPainter {
  _ScrollBarPainter({
    required this.thumbWidth,
    required this.progress,
    required this.fractionOfThumb,
    required this.index,
  });

  final double progress;
  final double fractionOfThumb;
  final double index;
  final double thumbWidth;

  @override
  void paint(Canvas canvas, Size size) {
    print("fractionOfThumb:$fractionOfThumb index:$index progress:$progress");
    final Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round;
    canvas.drawRect(Rect.fromLTWH(0, 0, thumbWidth, size.height), paint);
    final Paint paint2 = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round;
    double thumbHeight = size.height * fractionOfThumb;
    thumbHeight = thumbHeight < 10 ? 10 : thumbHeight;
    final double thumbTop = (size.height - thumbHeight) * progress;
    final double radius = thumbWidth / 2;
    final RRect rect = RRect.fromRectAndCorners(
      Rect.fromLTWH(0, thumbTop, size.width, thumbHeight),
      topLeft: Radius.circular(radius),
      topRight: Radius.circular(radius),
      bottomLeft: Radius.circular(radius),
      bottomRight: Radius.circular(radius),
    );
    canvas.drawRRect(rect, paint2);
  }

  @override
  bool shouldRepaint(covariant _ScrollBarPainter oldDelegate) {
    return progress != oldDelegate.progress ||
        fractionOfThumb != oldDelegate.fractionOfThumb ||
        index != oldDelegate.index;
  }
}
