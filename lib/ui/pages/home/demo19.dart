import 'package:flutter/material.dart';
import 'package:flutter_advanced/widgets/custom_scroll_bar.dart';

class Demo19 extends StatefulWidget {
  const Demo19({super.key});

  static String title = '自定义滚动条二';
  static String routeName = 'demo19';

  @override
  State<Demo19> createState() => _Demo19State();
}

class _Demo19State extends State<Demo19> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollBar(builder: (BuildContext context, ScrollController scrollController) {
      return ListView.builder(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(title: Text('$index'));
        },
        itemCount: 100,
      );
    });
  }
}
