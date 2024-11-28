import 'package:biz_lib/biz_lib.dart';
import 'package:flutter/material.dart';

class Demo9 extends StatefulWidget {
  const Demo9({super.key});
  static String title = '节流防抖';
  static String routeName = 'demo9';

  @override
  State<Demo9> createState() => _Demo9State();
}

class _Demo9State extends State<Demo9> {
  ThrottleDebounce throttleDebounce = ThrottleDebounce();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: <Widget>[
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.orangeAccent),
              shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            ),
            onPressed: () {
              throttleDebounce.call(
                waitTime: 1000,
                lastWaitTime: 1000,
                function: ([dynamic value]) {
                  JLogger.i('添加1秒节流防抖${DateTime.now().millisecondsSinceEpoch},$value');
                },
              );
            },
            child: const Text('节流防抖'),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.teal),
              shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            ),
            onPressed: () {
              JLogger.i('未添加节流防抖${DateTime.now().millisecondsSinceEpoch}');
            },
            child: const Text('未添加节流防抖'),
          ),
        ],
      ),
    );
  }
}
