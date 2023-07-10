import 'package:flutter/material.dart';
import 'package:flutter_advanced/entity/user_info.dart';
import 'package:provider/provider.dart';

class Demo12 extends StatefulWidget {
  const Demo12({Key? key}) : super(key: key);

  @override
  State<Demo12> createState() => _Demo12State();
}

class _Demo12State extends State<Demo12> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ChangeNotifierProvider"),
      ),
      body: ChangeNotifierProvider<UserInfoChanged>(
        create: (BuildContext context) {
          return UserInfoChanged();
        },
        child: const ChangeNotifierTest(),
      ),
    );
  }
}

class ChangeNotifierTest extends StatefulWidget {
  const ChangeNotifierTest({Key? key}) : super(key: key);

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
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
          ),
          onPressed: () {
            _userInfoChanged.setUserInfo("Tomas", 30);
          },
          child: const Text('ChangeNotifier通知改变'),
        ),
      ],
    );
  }

  @override
  void initState() {
    _userInfoChanged.addListener(() {
      print("userInfoChanged addListener:${_userInfoChanged.userInfo}");
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
