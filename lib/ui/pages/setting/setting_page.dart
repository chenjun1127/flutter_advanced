import 'package:flutter/material.dart';
import 'package:flutter_advanced/routes/animate_route.dart';

import '../../../routes/filter_gradient.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ElevatedButton(onPressed: _onPressed, child: const Text("点击跳转")),
            ElevatedButton(onPressed: toPge, child: const Text("点击跳转2"))
          ],
        ),
      ),
    );
  }

  void toPge(){
    scalePageRoute(builder: (BuildContext context) {
      return SecondPage();
    }, context: context);
    // Navigator.of(context).push(createRoute1(SecondPage()));
    // Navigator.of(context).push(_createRoute());
  }

  void _onPressed() {
    Navigator.of(context).push(
      ScaleToRouter<void>(
        builder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          return const SecondPage();
        },
        routeSettings: const RouteSettings(name: "SecondPage", arguments: <String, dynamic>{"name": "张三"}),
      ),
    );
  }
}


class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('Second Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
              child: const Text('Go Back'),
            ),
            Text("${ModalRoute.of(context)!.settings.arguments}")
          ],
        ),
      ),
    );
  }
}


Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => SecondPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return _ZoomPageTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        isScale: true,
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 300),
  );
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
          child: child,
          animation: animation,
          reverse: true,
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
    this.isScale = false,
    this.reverse = false,
  });

  final Animation<double> animation;
  final Widget? child;
  final bool isScale;
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    final scaleAnimation = Tween<double>(
      begin: reverse ? 1.0 : 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOut,
    ));

    final fadeAnimation = Tween<double>(
      begin: reverse ? 1.0 : 0.0,
      end: 1.0,
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
    final scaleAnimation = Tween<double>(
      begin: 1.0,
      end: reverse ? 1.0 : 0.0,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOut,
    ));

    final fadeAnimation = Tween<double>(
      begin: 1.0,
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