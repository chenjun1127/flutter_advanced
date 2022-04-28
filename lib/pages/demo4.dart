import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced/entity/user_info.dart';
import 'package:flutter_advanced/widgets/base_container.dart';

class Demo4 extends StatefulWidget {
  const Demo4({Key? key}) : super(key: key);

  @override
  State<Demo4> createState() => _Demo4State();
}

class _Demo4State extends State<Demo4> {
  final UserInfoNotifier userInfoNotifier = UserInfoNotifier(UserInfo());

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
            userInfoNotifier.setUserInfo("Tony", 32);
          },
          child: const Text('点击看效果'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: BaseContainer(
        child: ValueListenableBuilder<UserInfo>(
          builder: (BuildContext context, UserInfo userInfo, Widget? child) {
            return Text("姓名是：${userInfo.name ?? ""}，年龄是: ${userInfo.age ?? ""}");
          },
          valueListenable: userInfoNotifier,
        ),
      ),
    );
  }
}

class UserInfoNotifier extends ValueNotifier<UserInfo> {
  UserInfoNotifier(UserInfo userInfo) : super(userInfo);

  void setUserInfo(String name, int age) {
    value.name = name;
    value.age = age;
    notifyListeners();
  }
}
