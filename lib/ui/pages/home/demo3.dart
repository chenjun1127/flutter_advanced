import 'package:flutter/material.dart';
import 'package:flutter_advanced/widgets/base_container.dart';

class Demo3 extends StatelessWidget {
  const Demo3({Key? key}) : super(key: key);
  static String routeName = 'demo3';
  static String title = '从下至少动画路由带参数';

  @override
  Widget build(BuildContext context) {
    final RouteSettings? routeSettings = ModalRoute.of(context)?.settings;
    return BaseContainer(
      child: Text("${routeSettings!.name.toString()}---${routeSettings.arguments.toString()}"),
    );
  }
}
