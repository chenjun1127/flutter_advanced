import 'dart:async';

import 'package:biz_lib/biz_lib.dart';
import 'package:flutter/material.dart';

class OverlayWidget extends StatefulWidget {
  const OverlayWidget({
    required this.overlayKey,
    this.isSupportAutoClos = false,
    this.seconds = 3000,
    this.builder,
    this.removeFunction,
    super.key,
  });

  final String overlayKey;
  final WidgetBuilder? builder;
  final Function(String key)? removeFunction;
  final bool isSupportAutoClos;
  final int seconds;

  @override
  State<StatefulWidget> createState() {
    return OverlayWidgetState();
  }
}

class OverlayWidgetState extends State<OverlayWidget> {
  Timer? timer;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerUp: (_) {
        startTimer();
      },
      onPointerDown: (_) {
        timer?.cancel();
      },
      child: widget.builder?.call(context),
    );
  }

  void startTimer() {
    JLogger.i("${widget.overlayKey}是否支持倒计时关闭：${widget.isSupportAutoClos}");
    if (widget.isSupportAutoClos) {
      timer?.cancel();
      timer = Timer(Duration(seconds: widget.seconds), cancelHandle);
    }
  }

  void cancelHandle() {
    JLogger.i("${widget.overlayKey} overlay 倒计时回调");
    widget.removeFunction?.call(widget.overlayKey);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
