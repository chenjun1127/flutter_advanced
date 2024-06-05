import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced/routes/routes.dart';
import 'package:flutter_advanced/ui/pages/getx/get_view_demo.dart';
import 'package:flutter_advanced/ui/pages/getx/obx_list_demo.dart';

class GetXPage extends StatelessWidget {
  const GetXPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return buildItem(index, context);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 0.5),
      itemCount: getXRouteMap.keys.length,
    );
  }

  Widget buildItem(int index, BuildContext context) {
    return CupertinoButton(
      child: Container(
        alignment: Alignment.centerLeft,
        child: Text(getXRouteMap.keys.toList()[index], style: const TextStyle(color: Colors.black, fontSize: 18)),
      ),
      onPressed: () {
        if (index == 0) {
          Navigator.pushNamed(context, GetViewDemo.routeName);
        } else if (index == 1) {
          Navigator.pushNamed(context, ObxListDemo.routeName);
        } else if (index == 2) {
          // Navigator.pushNamed(context, ValueNotifierWidget.routeName);
        }
      },
    );
  }
}
