import 'package:common_lib/entity/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced/content/value_notifier_widget.dart';
import 'package:flutter_advanced/routes/animate_route.dart';
import 'package:flutter_advanced/stream/stream_controller.dart';
import 'package:flutter_advanced/widgets/base_container.dart';

class StreamSubscriptionWidget extends StatefulWidget {
  const StreamSubscriptionWidget({Key? key}) : super(key: key);
  static const String routeName = "stream_subscription_widget";

  @override
  State<StreamSubscriptionWidget> createState() => _StreamSubscriptionWidgetState();
}

class _StreamSubscriptionWidgetState extends State<StreamSubscriptionWidget> {
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
                        return ValueNotifierWidget(userInfo: userInfo);
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
