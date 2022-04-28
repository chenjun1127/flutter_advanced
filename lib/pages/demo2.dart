import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced/widgets/base_container.dart';

class Demo2 extends StatelessWidget {
  const Demo2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("普通渐隐动画路由")),
      body: const BaseContainer(child: Center(child: Text("普通渐隐动画路由，无参数"))),
    );
  }
}
