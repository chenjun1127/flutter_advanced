import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced/routes/animate_route.dart';
import 'package:flutter_advanced/routes/route_type.dart';
import 'package:flutter_advanced/routes/routes.dart' as routes;
import 'package:flutter_advanced/ui/not_found_page.dart';
import 'package:flutter_advanced/ui/pages/home/index.dart';

class PageScaffold extends StatefulWidget {
  const PageScaffold({
    required this.title,
    required this.body,
    this.padding = false,
    Key? key,
  }) : super(key: key);

  final String title;
  final Widget body;
  final bool padding;

  @override
  State<PageScaffold> createState() => _PageScaffoldState();
}

class _PageScaffoldState extends State<PageScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return widget.padding
        ? Padding(
            padding: const EdgeInsets.all(16),
            child: widget.body,
          )
        : widget.body;
  }
}

class Page {
  Page(
    this.title,
    this.routeName,
    Widget child, {
    this.withScaffold = true,
    this.padding = true,
  }) : builder = ((BuildContext context, {dynamic arguments}) {
          if (withScaffold) {
            return PageScaffold(title: title, body: child);
          } else {
            return child;
          }
        });

  String title;
  routes.WidgetBuilder builder;
  bool withScaffold;
  bool padding;
  String routeName;
}

class ListPage extends StatelessWidget {
  const ListPage({required this.children, Key? key}) : super(key: key);

  final List<Page> children;

  @override
  Widget build(BuildContext context) {
    return ListView(children: _generateItem(context));
  }

  List<Widget> _generateItem(BuildContext context) {
    return children
        .mapIndexed((int index, Page page) => ListTile(
            title: Text("demo${index + 1} - ${page.title}"),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () => _onTap(context, index)))
        .toList();
  }

  void _onTap(BuildContext context, int index) {
    if (index == 0) {
      Navigator.pushNamed(context, Demo1.routeName, arguments: <String, dynamic>{
        "name": "张三",
        "from": "普通路由传参数",
        "routeType": RouteType.bottomToTop,
      });
    } else if (index == 1) {
      Navigator.push(
        context,
        FadeRouter<dynamic>(
          child: Page(Demo2.routeName, Demo2.title, const Demo2()).builder(context),
        ),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        BottomToTopRouter<dynamic>(
          builder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return Page(Demo3.routeName, Demo3.title, const Demo3()).builder(context);
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
      if (index < routes.routeList.length) {
        Navigator.pushNamed(context, 'demo${routes.routeList[index] + 1}');
      } else {
        Navigator.push(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => const NotFoundPage(),
          ),
        );
      }
    }
  }
}
