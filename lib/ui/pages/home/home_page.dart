import 'package:flutter/material.dart';
import 'package:flutter_advanced/routes/animate_route.dart';
import 'package:flutter_advanced/routes/route_type.dart';
import 'package:flutter_advanced/routes/routes.dart';
import 'package:flutter_advanced/ui/not_found_page.dart';
import 'package:flutter_advanced/ui/pages/home/demo2.dart';
import 'package:flutter_advanced/ui/pages/home/demo3.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        itemCount: baseRoute.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.6,
        ),
        itemBuilder: (BuildContext context, int index) {
          return buildItem(index, context);
        },
      ),
    );
  }

  Widget buildItem(int index, BuildContext context) {
    return TextButton(
      onPressed: () {
        if (index == 0) {
          Navigator.pushNamed(context, 'demo1', arguments: <String, dynamic>{
            "name": "张三",
            "from": "普通路由传参数",
            "routeType": RouteType.bottomToTop,
          });
        } else if (index == 1) {
          Navigator.push(context, FadeRouter<dynamic>(child: const Demo2(), duration: 200));
        } else if (index == 2) {
          Navigator.push(
            context,
            BottomToTopRouter<dynamic>(
              builder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                return const Demo3();
              },
              settings: const RouteSettings(
                name: "demo3",
                arguments: <String, dynamic>{
                  "name": "demo3",
                  "from": "支持带参数的路由动画从下到上出现",
                  "routeType": RouteType.bottomToTop,
                },
              ),
            ),
          );
        } else {
          if (index < baseRoute.length) {
            Navigator.pushNamed(context, 'demo${routeList[index] + 1}');
          } else {
            Navigator.push(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => const NotFoundPage(),
              ),
            );
          }
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(getColor),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 18)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      ),
      child: Text((index + 1).toString()),
    );
  }

  Color? getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.teal;
  }
}
