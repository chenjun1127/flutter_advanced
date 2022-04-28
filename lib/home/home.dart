import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced/pages/demo2.dart';
import 'package:flutter_advanced/pages/demo3.dart';
import 'package:flutter_advanced/routes/animate_route.dart';
import 'package:flutter_advanced/routes/route_type.dart';
import 'package:flutter_advanced/routes/routes.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        itemCount: 20,
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
          Navigator.pushNamed(context, '/demo1', arguments: <String, dynamic>{
            "name": "张三",
            "from": "普通路由传参数",
            "routeType": ROUTE_TYPE.bottomToTop,
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
                name: "/demo3",
                arguments: <String, dynamic>{
                  "name": "demo3",
                  "from": "支持带参数的路由动画从下到上出现",
                  "routeType": ROUTE_TYPE.bottomToTop,
                },
              ),
            ),
          );
        } else {
          Navigator.pushNamed(context, '/demo${routeList[index] + 1}');
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(getColor),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 18)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      ),
      child: Text(index.toString()),
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
