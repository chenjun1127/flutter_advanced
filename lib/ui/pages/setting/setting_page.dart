import 'package:flutter/material.dart';
import 'package:flutter_advanced/routes/animate_route.dart';
import 'package:flutter_advanced/routes/scale_page_route.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ElevatedButton(onPressed: _onPressed, child: const Text("点击跳转")),
            ElevatedButton(onPressed: toPge, child: const Text("点击跳转2"))
          ],
        ),
      ),
    );
  }

  void toPge() {
    scalePageRoute(
        builder: (BuildContext context) {
          return const SecondPage();
        },
        context: context);
    // Navigator.of(context).push(createRoute1(SecondPage()));
    // Navigator.of(context).push(_createRoute());
  }

  void _onPressed() {
    Navigator.of(context).push(
      ScaleToRouter<void>(
        builder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          return const SecondPage();
        },
        routeSettings: const RouteSettings(name: "SecondPage", arguments: <String, dynamic>{"name": "张三"}),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('Second Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
              child: const Text('Go Back'),
            ),
            Text("${ModalRoute.of(context)!.settings.arguments}")
          ],
        ),
      ),
    );
  }
}
