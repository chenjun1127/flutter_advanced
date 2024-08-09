import 'package:flutter/material.dart';
import 'package:flutter_advanced/styles/styles.dart';

class Demo21 extends StatefulWidget {
  const Demo21({super.key});

  @override
  State<Demo21> createState() => _Demo21State();
}

class _Demo21State extends State<Demo21> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Hero过渡动画效果")),
      body: Container(alignment: Alignment.center, child: _buildButton()),
    );
  }

  Widget _buildButton() {
    return Hero(
      tag: "heroTag",
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.push(context, MaterialPageRoute<void>(builder: (_) {
            return const SecondPage();
          }));
        },
        child: Container(
          width: 200,
          height: 200,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
          ),
          child: Text(
            "1113123213",
            style: FontStyle.defaultTitle.copyWith(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
          ),
        ),
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
      body: Container(
        alignment: Alignment.center,
        child: Hero(
          tag: "heroTag",
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 150,
              height: 150,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              child: Text(
                "Back",
                style: FontStyle.defaultTitle.copyWith(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
