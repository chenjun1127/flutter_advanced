import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced/pages/demo1.dart';
import 'package:flutter_advanced/pages/main_page.dart';
import 'package:flutter_advanced/routes/animate_route.dart';
import 'package:flutter_advanced/routes/route_type.dart';

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
    final Object? arguments = settings.arguments;
    if (builder != null) {
      if (settings.arguments != null) {
        if (arguments is Map) {
          if (arguments['routeType'] == ROUTE_TYPE.bottomToTop) {
            final Route<dynamic> route = BottomToTopRouter<dynamic>(
                builder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                  return builder(context, arguments: settings.arguments);
                },
                settings: settings);
            return route;
          }
        }
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
