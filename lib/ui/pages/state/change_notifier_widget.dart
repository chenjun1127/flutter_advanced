
import 'package:biz_lib/biz_lib.dart';
import 'package:biz_lib/entity/counter.dart';
import 'package:biz_lib/entity/user_info.dart';
import 'package:flutter/material.dart';

class ChangeNotifierWidget extends StatefulWidget {
  const ChangeNotifierWidget({super.key});

  static const String routeName = 'change_notifier_provider_widget';

  @override
  State<ChangeNotifierWidget> createState() => _ChangeNotifierWidgetState();
}

class _ChangeNotifierWidgetState extends State<ChangeNotifierWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChangeNotifierProvider'),
      ),
      body: ChangeNotifierProvider<UserInfoChanged>(
        create: (BuildContext context) {
          return UserInfoChanged();
        },
        child: Column(
          children: <Widget>[
            const ChangeNotifierTest(),
            ValueNotifierTest(),
          ],
        ),
      ),
    );
  }
}

class ChangeNotifierTest extends StatefulWidget {
  const ChangeNotifierTest({super.key});

  @override
  State<ChangeNotifierTest> createState() => _ChangeNotifierTestState();
}

class _ChangeNotifierTestState extends State<ChangeNotifierTest> {
  final UserInfoChanged _userInfoChanged = UserInfoChanged();
  UserInfo currentUserInfo = UserInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: Text(currentUserInfo.toString()),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.blue),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
          ),
          onPressed: () {
            _userInfoChanged.setUserInfo('Tomas', 30);
          },
          child: const Text('ChangeNotifier通知改变'),
        ),
      ],
    );
  }

  @override
  void initState() {
    _userInfoChanged.addListener(() {
      JLogger.i('userInfoChanged addListener:${_userInfoChanged.userInfo}');
      setState(() {
        currentUserInfo = _userInfoChanged.userInfo;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _userInfoChanged.dispose();
  }
}

class UserInfoChanged extends ChangeNotifier {
  final UserInfo _userInfo = UserInfo();

  UserInfo get userInfo => _userInfo;

  void setUserInfo(String name, int age) {
    _userInfo.name = name;
    _userInfo.age = age;
    notifyListeners();
  }
}

class ValueNotifierTest extends StatelessWidget {
  ValueNotifierTest({super.key});

  final Counter counter = Counter();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: counter.count,
      builder: (BuildContext context, int value, Widget? child) {
        return Column(
          children: <Widget>[
            Text('Count: $value'),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(value >= 5 ? Colors.blue : Colors.green),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
              ),
              onPressed: counter.add,
              child: const Text('ValueNotifierTest'),
            ),
          ],
        );
      },
    );
  }
}
