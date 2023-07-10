import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced/utils/debonce_throttle.dart';

class Demo11 extends StatefulWidget {
  const Demo11({Key? key}) : super(key: key);

  @override
  State<Demo11> createState() => _Demo11State();
}

class _Demo11State extends State<Demo11> {
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
                    print("添加1秒节流防抖${DateTime.now().millisecondsSinceEpoch},$value");
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
                print("未添加节流防抖${DateTime.now().millisecondsSinceEpoch}");
              },
              child: const Text('未添加节流防抖'),
            ),
          ],
        ),
      ),
    );
  }
}
