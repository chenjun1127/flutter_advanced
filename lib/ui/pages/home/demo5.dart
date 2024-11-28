import 'package:biz_lib/biz_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced/widgets/base_container.dart';

class Demo5 extends StatefulWidget {
  const Demo5({super.key});
  static String routeName = 'demo5';
  static String title = 'Flutter 屏幕适配方案';

  @override
  State<Demo5> createState() => _Demo5State();
}

class _Demo5State extends State<Demo5> {
  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      child: Center(
        child: Container(
          width: 400.dpx,
          height: 400.dpx,
          color: Colors.red,
          child: const Text('dpx 适配'),
        ),
      ),
    );
  }
}
