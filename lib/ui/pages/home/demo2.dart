import 'package:flutter/material.dart';
import 'package:flutter_advanced/widgets/base_container.dart';

class Demo2 extends StatelessWidget {
  const Demo2({super.key});
  static String routeName = 'demo2';
  static String title = '普通渐隐动画路由';

  @override
  Widget build(BuildContext context) {
    return const BaseContainer(
      child: Center(child: Text('普通渐隐动画路由，无参数')),
    );
  }
}
