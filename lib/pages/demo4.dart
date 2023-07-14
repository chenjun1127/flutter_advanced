import 'package:flutter/material.dart';
import 'package:flutter_advanced/entity/user_info.dart';
import 'package:flutter_advanced/pages/demo5.dart';
import 'package:flutter_advanced/routes/animate_route.dart';
import 'package:flutter_advanced/stream/stream_controller.dart';
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
      appBar: AppBar(title: const Text("StreamSubscription 的基本使用")),
      body: BaseContainer(
        child: Column(
          children: <Widget>[
            ValueListenableBuilder<UserInfo>(
              builder: (BuildContext context, UserInfo userInfo, Widget? child) {
                return Text("姓名是：${userInfo.name ?? ""}，年龄是: ${userInfo.age ?? ""}");
              },
              valueListenable: userInfoNotifier,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 220,
              height: 48,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                ),
                onPressed: () {
                  userInfoNotifier.setUserInfo("Tony", 32);
                },
                child: const Text('ValueNotifier触发通知改变'),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 220,
              height: 48,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                ),
                onPressed: () {
                  final UserInfo userInfo = userInfoNotifier.value;
                  streamController.add(userInfo);
                  Navigator.push(
                    context,
                    BottomToTopRouter<dynamic>(
                      builder: (BuildContext context, Animation<double> a, Animation<double> s) {
                        return Demo5(userInfo: userInfo);
                      },
                    ),
                  );
                },
                child: const Text('Stream流订阅通知'),
              ),
            )
          ],
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
