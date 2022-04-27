import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced/pages/demo1.dart';
import 'package:flutter_advanced/pages/main_page.dart';

final List<int> list = List<int>.generate(baseRoute.values.length, (int index) => index);

typedef WidgetBuilder = Widget Function(BuildContext context, {dynamic arguments});

final Map<String, WidgetBuilder> baseRoute = <String, WidgetBuilder>{
  "/demo1": (BuildContext context, {dynamic arguments}) => const Demo1(),
};

class Routes {
  ///路由配置
  static Map<String, WidgetBuilder> initRoutes() {
    return <String, WidgetBuilder>{
      '/': (BuildContext context, {dynamic arguments}) => const MainPage(),
      ...baseRoute,
    };
  }

  ///路由跳转拦截，支持传参
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final String name = settings.name ?? '';
    final Map<String, WidgetBuilder> routes = initRoutes();
    final WidgetBuilder? builder = routes[name];
    if (builder != null) {
      if (settings.arguments != null) {
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => builder(context, arguments: settings.arguments),
          settings: settings,
        ); //此处将参数传递给ModalRoute
      } else {
        return MaterialPageRoute<dynamic>(builder: builder);
      }
    }
  }
}
