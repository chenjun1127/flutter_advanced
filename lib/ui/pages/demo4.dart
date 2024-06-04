import 'package:common_lib/common_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Demo4 extends StatefulWidget {
  const Demo4({Key? key}) : super(key: key);

  @override
  State<Demo4> createState() => _Demo4State();
}

// addPostFrameCallback 是 StatefulWidget 渲染结束的回调，只会被调用一次，之后 StatefulWidget 需要刷新 UI 也不会被调用，
class _Demo4State extends State<Demo4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SchedulerBinding")),
      body: Container(),
    );
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      JLogger.i("渲染完成");
    });
    super.initState();
  }
}
