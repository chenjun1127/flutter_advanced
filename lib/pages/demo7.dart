import 'package:flutter/material.dart';
import 'package:flutter_advanced/utils/screen_adapt.dart';
import 'package:flutter_advanced/widgets/base_container.dart';

class Demo7 extends StatefulWidget {
  const Demo7({Key? key}) : super(key: key);

  @override
  State<Demo7> createState() => _Demo7State();
}

class _Demo7State extends State<Demo7> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter 屏幕适配方案")),
      body: BaseContainer(
        child: Center(
          child: Container(
            width: 400.dpx,
            height: 400.dpx,
            color: Colors.red,
            child: const Text("dpx 适配"),
          ),
        ),
      ),
    );
  }
}
