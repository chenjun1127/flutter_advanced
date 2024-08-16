import 'package:flutter/cupertino.dart';

///渐隐动画路由
class FadeRouter<T> extends PageRouteBuilder<T> {
  FadeRouter({this.child, this.duration = 300, this.curve = Curves.linear, RouteSettings? routeSettings})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) =>
              child!,
          transitionDuration: Duration(milliseconds: duration),
          settings: routeSettings,
          transitionsBuilder:
              (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
            return FadeTransition(
              opacity: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: animation, curve: curve)),
              child: child,
            );
          },
        );

  final Widget? child;
  final int duration;
  final Curve curve;
}

///支持带参数的路由动画
class BottomToTopRouter<T> extends PageRouteBuilder<T> {
  BottomToTopRouter({
    required this.builder,
    RouteSettings? settings,
    this.duration = 200,
    this.curve = Curves.fastOutSlowIn,
  })  : settings = settings ?? defaultSettings,
        super(
          pageBuilder: builder,
          settings: settings,
          transitionDuration: Duration(milliseconds: duration),
          transitionsBuilder:
              (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
            return SlideTransition(
              position: Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(
                CurvedAnimation(parent: animation, curve: curve),
              ),
              child: child,
            );
          },
        ) {
    settings = const RouteSettings();
  }

  final int duration;
  static RouteSettings defaultSettings = const RouteSettings();

  final RoutePageBuilder builder;
  @override
  RouteSettings settings;
  final Curve curve;
}

///缩放路由动画
///transitionsBuilder 方法中嵌套了两个 ScaleTransition，一个用于处理页面进场动画，另一个用于处理页面退场动画。
class ScaleToRouter<T> extends PageRouteBuilder<T> {
  ScaleToRouter({
    required this.builder,
    this.duration = 200,
    this.routeSettings,
    this.curve = Curves.linear,
  }) : super(
          pageBuilder: builder,
          transitionDuration: Duration(milliseconds: duration),
          settings: routeSettings,
          transitionsBuilder:
              (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
            const double begin = 0;
            const double end = 1;
            const Cubic curve = Curves.ease;

            return ScaleTransition(
              scale: Tween<double>(begin: begin, end: end).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: const Interval(0.5, 1, curve: curve),
                ),
              ),
              child: ScaleTransition(
                scale: Tween<double>(begin: end, end: begin).animate(
                  CurvedAnimation(
                    parent: secondaryAnimation,
                    curve: const Interval(0, 0.5, curve: curve),
                  ),
                ),
                child: child,
              ),
            );
          },
          opaque: true,
        );
  final RouteSettings? routeSettings;
  final int duration;
  final RoutePageBuilder builder;
  final Curve curve;
}
