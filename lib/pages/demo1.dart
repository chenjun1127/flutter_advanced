import 'package:flutter/material.dart';
import 'package:flutter_advanced/widgets/base_container.dart';

class Demo1 extends StatelessWidget {
  const Demo1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RouteSettings? routeSettings = ModalRoute.of(context)?.settings;
    final Map<String, dynamic>? arguments = routeSettings?.arguments as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(title: const Text('路由传参')),
      body: BaseContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('参数：${arguments?['name'] ?? ''}----from:${arguments?['from'] ?? ''}'),
            Text('路由名称：${routeSettings?.name}'),
          ],
        ),
      ),
    );
  }
}
