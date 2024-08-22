import 'package:flutter/material.dart' hide Page;
import 'package:flutter_advanced/routes/animate_route.dart';
import 'package:flutter_advanced/routes/route_type.dart';
import 'package:flutter_advanced/ui/home_layout.dart';
import 'package:flutter_advanced/ui/pages/getx/get_view_demo.dart';
import 'package:flutter_advanced/ui/pages/getx/obx_list_demo.dart';
import 'package:flutter_advanced/ui/pages/home/index.dart';
import 'package:flutter_advanced/ui/pages/state/change_notifier_widget.dart';
import 'package:flutter_advanced/ui/pages/state/stream_subscription_widget.dart';
import 'package:flutter_advanced/ui/pages/state/value_notifier_widget.dart';
import 'package:flutter_advanced/widgets/page_scaffold.dart';

final List<int> routeList = List<int>.generate(getRoutes().length, (int index) => index);

typedef WidgetBuilder = Widget Function(BuildContext context, {dynamic arguments});

List<Page> getRoutes() {
  return <Page>[
    Page(Demo1.title, Demo1.routeName, const Demo1()),
    Page(Demo2.title, Demo2.routeName, const Demo2()),
    Page(Demo3.title, Demo3.routeName, const Demo3()),
    Page(Demo4.title, Demo4.routeName, const Demo4()),
    Page(Demo5.title, Demo5.routeName, const Demo5()),
    Page(Demo6.title, Demo6.routeName, const Demo6()),
    Page(Demo7.title, Demo7.routeName, const Demo7(), withScaffold: false),
    Page(Demo8.title, Demo8.routeName, const Demo8()),
    Page(Demo9.title, Demo9.routeName, const Demo9()),
    Page(Demo10.title, Demo10.routeName, const Demo10()),
    Page(Demo11.title, Demo11.routeName, const Demo11()),
    Page(Demo12.title, Demo12.routeName, const Demo12()),
    Page(Demo13.title, Demo13.routeName, const Demo13()),
    Page(Demo14.title, Demo14.routeName, const Demo14()),
    Page(Demo15.title, Demo15.routeName, const Demo15()),
    Page(Demo16.title, Demo16.routeName, const Demo16()),
    Page(Demo17.title, Demo17.routeName, const Demo17()),
    Page(Demo18.title, Demo18.routeName, const Demo18()),
    Page(Demo19.title, Demo19.routeName, const Demo19()),
    Page(Demo20.title, Demo20.routeName, const Demo20()),
    Page(Demo21.title, Demo21.routeName, const Demo21()),
    Page(Demo22.title, Demo22.routeName, const Demo22()),
    Page(Demo23.title, Demo23.routeName, const Demo23()),
    Page(Demo24.title, Demo24.routeName, const Demo24(), withScaffold: false),
    Page(Demo25.title, Demo25.routeName, const Demo25()),
  ];
}

Map<String, WidgetBuilder> mapRoutes(List<Page> pages) {
  return pages.fold(<String, WidgetBuilder>{}, (Map<String, WidgetBuilder> pre, Page page) {
    pre[page.routeName] = page.builder;
    return pre;
  });
}

final Map<String, WidgetBuilder> routeMap = <String, WidgetBuilder>{
  ChangeNotifierWidget.routeName: (BuildContext context, {dynamic arguments}) => const ChangeNotifierWidget(),
  StreamSubscriptionWidget.routeName: (BuildContext context, {dynamic arguments}) => const StreamSubscriptionWidget(),
  ValueNotifierWidget.routeName: (BuildContext context, {dynamic arguments}) => const ValueNotifierWidget(),
};
final Map<String, WidgetBuilder> getXRouteMap = <String, WidgetBuilder>{
  GetViewDemo.routeName: (BuildContext context, {dynamic arguments}) => const GetViewDemo(),
  ObxListDemo.routeName: (BuildContext context, {dynamic arguments}) => const ObxListDemo(),
};

class Routes {
  ///路由配置
  static Map<String, WidgetBuilder> initRoutes() {
    return <String, WidgetBuilder>{
      HomeLayout.routeName: (BuildContext context, {dynamic arguments}) => const HomeLayout(),
      ...mapRoutes(getRoutes()),
      ...routeMap,
      ...getXRouteMap,
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
          if (arguments['routeType'] == RouteType.bottomToTop) {
            final Route<dynamic> route = BottomToTopRouter<dynamic>(
                builder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                  return builder(context, arguments: settings.arguments);
                },
                settings: settings);
            return route;
          }
        }
        return MaterialPageRoute<dynamic>(builder: builder, settings: settings); //此处将参数传递给ModalRoute
      } else {
        return MaterialPageRoute<dynamic>(builder: builder, settings: settings);
      }
    }
    return null;
  }
}
