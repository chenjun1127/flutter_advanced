import 'package:flutter/material.dart';

Future<T?>? scalePageRoute<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  RouteSettings? settings,
  PageTransitionsBuilder? pageBuilder,
}) {
  return Navigator.of(context).push(
    MyMaterialPageRoute<T>(
      settings: settings,
      opaque: false,
      pageTransitionsBuilder: MyPageTransitionBuilder(),
      builder: (BuildContext context) {
        return builder(context);
      },
    ),
  );
}

class MyMaterialPageRoute<T> extends PageRoute<T> with MaterialRouteTransitionMixin<T> {
  MyMaterialPageRoute({
    required this.builder,
    super.settings,
    this.maintainState = true, //是否在路由不活动时保持其状态。
    this.pageTransitionsBuilder,
    this.opaque = true, //opaque: 是否设置路由为不透明。
  });

  @override
  final bool opaque;
  final PageTransitionsBuilder? pageTransitionsBuilder;

  final WidgetBuilder builder;

  @override
  Widget buildContent(BuildContext context) => builder(context);

  @override
  final bool maintainState;

  @override
  bool canTransitionFrom(TransitionRoute<dynamic> previousRoute) {
    // 确定当前路由是否可以从前一个路由进行过渡。在这个实现中，返回 false 表示不能从前一个路由过渡。
    return false;
  }

  @override
  String get debugLabel => '${super.debugLabel}(${settings.name})';

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    final PageTransitionsTheme theme = Theme.of(context).pageTransitionsTheme;
    return pageTransitionsBuilder?.buildTransitions(this, context, animation, secondaryAnimation, child) ??
        theme.buildTransitions<T>(this, context, animation, secondaryAnimation, child);
  }
}

class MyPageTransitionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(PageRoute<T> route, BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return _ZoomPageTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      isScale: true,
      child: child,
    );
  }
}

class _ZoomPageTransition extends StatelessWidget {
  const _ZoomPageTransition({
    required this.animation,
    required this.secondaryAnimation,
    this.isScale,
    this.child,
  });

  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final bool? isScale;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return DualTransitionBuilder(
      animation: animation,
      forwardBuilder: (
        BuildContext context,
        Animation<double> animation,
        Widget? child,
      ) {
        return _ZoomEnterTransition(
          animation: animation,
          child: child,
        );
      },
      reverseBuilder: (
        BuildContext context,
        Animation<double> animation,
        Widget? child,
      ) {
        return _ZoomExitTransition(
          animation: animation,
          reverse: true,
          child: child,
        );
      },
      child: child,
    );
  }
}

class _ZoomEnterTransition extends StatelessWidget {
  const _ZoomEnterTransition({
    required this.animation,
    required this.child,
    bool? isScale,
    bool? reverse,
  })  : isScale = isScale ?? false,
        reverse = reverse ?? false;

  final Animation<double> animation;
  final Widget? child;
  final bool isScale;
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    final Animation<double> scaleAnimation = Tween<double>(
      begin: reverse ? 1.0 : 0.0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOut,
    ));

    final Animation<double> fadeAnimation = Tween<double>(
      begin: reverse ? 1.0 : 0.0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOut,
    ));

    return FadeTransition(
      opacity: fadeAnimation,
      child: ScaleTransition(
        scale: isScale ? scaleAnimation : animation,
        child: child,
      ),
    );
  }
}

class _ZoomExitTransition extends StatelessWidget {
  const _ZoomExitTransition({
    required this.animation,
    required this.child,
    this.reverse = false,
  });

  final Animation<double> animation;
  final Widget? child;
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    final Animation<double> scaleAnimation = Tween<double>(
      begin: 1,
      end: reverse ? 1.0 : 0.0,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOut,
    ));

    final Animation<double> fadeAnimation = Tween<double>(
      begin: 1,
      end: reverse ? 1.0 : 0.0,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOut,
    ));

    return FadeTransition(
      opacity: fadeAnimation,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: child,
      ),
    );
  }
}
