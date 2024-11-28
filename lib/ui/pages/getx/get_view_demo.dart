import 'package:biz_lib/biz_lib.dart';
import 'package:flutter/material.dart';

class GetViewDemo extends GetView<AwesomeController> {
  const GetViewDemo({super.key});

  static const String routeName = 'get_view_demo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GetView Demo')),
      body: Obx(() => Center(child: Text(controller.title))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.title = 'GetView Demo';
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
