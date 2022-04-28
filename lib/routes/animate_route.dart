import 'package:flutter/cupertino.dart';

///渐隐动画路由
class FadeRouter<T> extends PageRouteBuilder<T> {
  FadeRouter({this.child, this.duration = 300, this.curve = Curves.linear})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) =>
              child!,
          transitionDuration: Duration(milliseconds: duration),
          transitionsBuilder:
              (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) =>
                  FadeTransition(
            opacity: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: animation, curve: curve)),
            child: child,
          ),
        );
  final Widget? child;
  final int duration;

  final Curve curve;
}

///支持带参数的路由动画
class BottomToTopRouter<T> extends PageRouteBuilder<T> {
  BottomToTopRouter(
      {required this.builder, RouteSettings? settings, this.duration = 200, this.curve = Curves.fastOutSlowIn})
      : settings = settings ?? defaultSettings,
        super(
          pageBuilder: builder,
          settings: settings,
          transitionDuration: Duration(milliseconds: duration),
          transitionsBuilder:
              (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) =>
                  SlideTransition(
            position: Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(
              CurvedAnimation(parent: animation, curve: curve),
            ),
            // position: animation.drive(
            //   Tween<Offset>(begin: const Offset(0, 1), end:Offset.zero).chain(CurveTween(curve: curve)),
            // ),
            child: child,
          ),
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
class ScaleRouter<T> extends PageRouteBuilder<T> {
  ScaleRouter({this.child, this.duration = 300, this.curve = Curves.linear})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) =>
              child!,
          transitionDuration: Duration(milliseconds: duration),
          transitionsBuilder:
              (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) =>
                  ScaleTransition(
            scale: Tween<double>(begin: 1, end: 0.7).animate(CurvedAnimation(parent: animation, curve: curve)),
            child: child,
          ),
        );

  final Widget? child;
  final int duration;
  final Curve curve;
}
