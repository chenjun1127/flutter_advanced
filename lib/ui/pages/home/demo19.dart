import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced/widgets/custom_scroll_bar.dart';

class Demo19 extends StatefulWidget {
  const Demo19({super.key});

  @override
  State<Demo19> createState() => _Demo19State();
}

class _Demo19State extends State<Demo19> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("自定义滚动条")),
      body: CustomScrollBar(builder: (BuildContext context, ScrollController scrollController) {
        return ListView.builder(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return ListTile(title: Text("$index"));
          },
          itemCount: 100,
        );
      }),
    );
  }
}
