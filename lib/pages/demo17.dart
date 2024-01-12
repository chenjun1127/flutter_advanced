import 'package:cj_kit/logger/j_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced/widgets/custom_gesture_recognizer.dart';

class Demo17 extends StatelessWidget {
  const Demo17({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("手势冲突处理"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.red,
              child: GestureDetector(
                // 替换 GestureDetector
                onTap: () => JLogger.i("2"),
                child: Container(
                  width: 200,
                  height: 200,
                  color: Colors.teal,
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () => JLogger.i("1"),
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Container(
              color: Colors.transparent,
              child: Listener(
                // 替换 GestureDetector
                onPointerUp: (PointerUpEvent e) => JLogger.i("2"),
                child: Container(
                  width: 200,
                  height: 200,
                  color: Colors.green,
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () => JLogger.i("1"),
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Container(
              child: customGestureDetector(
                // 替换 GestureDetector
                onTap: () => JLogger.i("2"),
                child: Container(
                  width: 200,
                  height: 200,
                  color: Colors.red,
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () => JLogger.i("1"),
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
