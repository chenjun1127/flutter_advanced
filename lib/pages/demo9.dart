import 'package:common_lib/common_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced/utils/debounce_throttle.dart';

class Demo9 extends StatefulWidget {
  const Demo9({Key? key}) : super(key: key);

  @override
  State<Demo9> createState() => _Demo9State();
}

class _Demo9State extends State<Demo9> {
  ThrottleDebounce throttleDebounce = ThrottleDebounce();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('节流防抖'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              ),
              onPressed: () {
                throttleDebounce.call(
                  waitTime: 1000,
                  lastWaitTime: 1000,
                  function: ([dynamic value]) {
                    JLogger.i("添加1秒节流防抖${DateTime.now().millisecondsSinceEpoch},$value");
                  },
                );
              },
              child: const Text('节流防抖'),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.teal),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              ),
              onPressed: () {
                JLogger.i("未添加节流防抖${DateTime.now().millisecondsSinceEpoch}");
              },
              child: const Text('未添加节流防抖'),
            ),
          ],
        ),
      ),
    );
  }
}
