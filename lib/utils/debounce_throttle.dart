import 'dart:async';


class ThrottleDebounce {
  Timer? _timer;
  int lastTime = 0;
  void Function()? function;

  /// [targetParam] 用于返回最终执行的目标参数
  /// [waitTime] 节流时间
  /// [lastWaitTime] 节流时间内延迟执行的时间
  /// [isSupportDebounce] 支持防抖
  /// [isSupportThrottle] 支持节流
  void call({
    required void Function([dynamic]) function,
    dynamic targetParam,
    int waitTime = 500,
    int lastWaitTime = 500,
    bool isSupportDebounce = true,
    bool isSupportThrottle = true,
    void Function()? deyFunction,
  }) {
    this.function = deyFunction;
    final DateTime dateTime = DateTime.now();
    if (dateTime.millisecondsSinceEpoch - lastTime >= waitTime && isSupportThrottle) {
      //超出节流时间执行一次
      lastTime = dateTime.millisecondsSinceEpoch;
      _timer?.cancel();
      if (targetParam == null) {
        function.call();
      } else {
        function.call(targetParam);
      }
      this.function = null;
    } else if (isSupportDebounce) {
      //在节流时间内执行最后执行一次
      _timer?.cancel();
      _timer = Timer(Duration(milliseconds: lastWaitTime), () {
        if (targetParam == null) {
          function.call();
        } else {
          function.call(targetParam);
        }
        this.function = null;
      });
    }
  }

  bool get isRunning => _timer?.isActive ?? false;

  void isActive({bool isUpDate = true}) {
    if (_timer?.isActive ?? false) {
      if (isUpDate) {
        print('-- isActive 取消的时候执行一次  ${function != null}');
        function?.call();
      }
      function = null;
    }
    _timer?.cancel();
  }

  void cancel({bool isUpDate = false}) {
    _timer?.cancel();
    if (isUpDate) {
      print('----- 取消的时候执行一次  ${function != null}');
      function?.call();
    }
    function = null;
  }
}


