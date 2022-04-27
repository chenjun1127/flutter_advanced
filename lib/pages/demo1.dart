import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Demo1 extends StatelessWidget {
  const Demo1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return Scaffold(
      appBar: AppBar(title: const Text('路由传参')),
      body: Container(
        color: Colors.red,
        child: Text(arguments?["name"] ?? ""),
      ),
    );
  }
}
