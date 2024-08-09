import 'dart:async';

import 'package:biz_lib/controller/stream_controller.dart';
import 'package:biz_lib/entity/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced/widgets/base_container.dart';

class ValueNotifierWidget extends StatefulWidget {
  const ValueNotifierWidget({this.userInfo, Key? key}) : super(key: key);
  final UserInfo? userInfo;
  static const String routeName = "value_notifier_widget";

  @override
  State<ValueNotifierWidget> createState() => _ValueNotifierWidgetState();
}

class _ValueNotifierWidgetState extends State<ValueNotifierWidget> {
  late StreamSubscription<UserInfo> streamSubscription;
  late UserInfo _userInfo = UserInfo();

  @override
  void initState() {
    _userInfo = widget.userInfo ?? UserInfo();
    streamSubscription = streamController.stream.listen((UserInfo userInfo) {
      setState(() {
        userInfo = userInfo;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ValueNotifier 的基本使用")),
      floatingActionButton: SizedBox(
        height: 50,
        width: 160,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          ),
          onPressed: () {
            _userInfo.name = "Lucy";
            _userInfo.age = 15;
            streamController.add(_userInfo);
          },
          child: const Text('点击再次改变'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: BaseContainer(
        child: Text("姓名是：${_userInfo.name ?? ""}，年龄是: ${_userInfo.age ?? ""}"),
      ),
    );
  }
}
