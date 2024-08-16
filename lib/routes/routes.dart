import 'package:flutter/material.dart';
import 'package:flutter_advanced/routes/animate_route.dart';
import 'package:flutter_advanced/routes/route_type.dart';
import 'package:flutter_advanced/ui/home_layout.dart';
import 'package:flutter_advanced/ui/pages/getx/get_view_demo.dart';
import 'package:flutter_advanced/ui/pages/getx/obx_list_demo.dart';
import 'package:flutter_advanced/ui/pages/home/demo1.dart';
import 'package:flutter_advanced/ui/pages/home/demo10.dart';
import 'package:flutter_advanced/ui/pages/home/demo11.dart';
import 'package:flutter_advanced/ui/pages/home/demo12.dart';
import 'package:flutter_advanced/ui/pages/home/demo13.dart';
import 'package:flutter_advanced/ui/pages/home/demo14.dart';
import 'package:flutter_advanced/ui/pages/home/demo15.dart';
import 'package:flutter_advanced/ui/pages/home/demo16.dart';
import 'package:flutter_advanced/ui/pages/home/demo17.dart';
import 'package:flutter_advanced/ui/pages/home/demo18.dart';
import 'package:flutter_advanced/ui/pages/home/demo19.dart';
import 'package:flutter_advanced/ui/pages/home/demo2.dart';
import 'package:flutter_advanced/ui/pages/home/demo20.dart';
import 'package:flutter_advanced/ui/pages/home/demo21.dart';
import 'package:flutter_advanced/ui/pages/home/demo3.dart';
import 'package:flutter_advanced/ui/pages/home/demo4.dart';
import 'package:flutter_advanced/ui/pages/home/demo5.dart';
import 'package:flutter_advanced/ui/pages/home/demo6.dart';
import 'package:flutter_advanced/ui/pages/home/demo7.dart';
import 'package:flutter_advanced/ui/pages/home/demo8.dart';
import 'package:flutter_advanced/ui/pages/home/demo9.dart';
import 'package:flutter_advanced/ui/pages/state/change_notifier_widget.dart';
import 'package:flutter_advanced/ui/pages/state/stream_subscription_widget.dart';
import 'package:flutter_advanced/ui/pages/state/value_notifier_widget.dart';

final List<int> routeList = List<int>.generate(baseRoute.values.length, (int index) => index);

typedef WidgetBuilder = Widget Function(BuildContext context, {dynamic arguments});

final Map<String, WidgetBuilder> baseRoute = <String, WidgetBuilder>{
  "demo1": (BuildContext context, {dynamic arguments}) => const Demo1(),
  "demo2": (BuildContext context, {dynamic arguments}) => const Demo2(),
  "demo3": (BuildContext context, {dynamic arguments}) => const Demo3(),
  "demo4": (BuildContext context, {dynamic arguments}) => const Demo4(),
  "demo5": (BuildContext context, {dynamic arguments}) => const Demo5(),
  "demo6": (BuildContext context, {dynamic arguments}) => const Demo6(),
  "demo7": (BuildContext context, {dynamic arguments}) => const Demo7(),
  "demo8": (BuildContext context, {dynamic arguments}) => const Demo8(),
  "demo9": (BuildContext context, {dynamic arguments}) => const Demo9(),
  "demo10": (BuildContext context, {dynamic arguments}) => const Demo10(),
  "demo11": (BuildContext context, {dynamic arguments}) => const Demo11(),
  "demo12": (BuildContext context, {dynamic arguments}) => const Demo12(),
  "demo13": (BuildContext context, {dynamic arguments}) => const Demo13(),
  "demo14": (BuildContext context, {dynamic arguments}) => const Demo14(),
  "demo15": (BuildContext context, {dynamic arguments}) => const Demo15(),
  "demo16": (BuildContext context, {dynamic arguments}) => const Demo16(),
  "demo17": (BuildContext context, {dynamic arguments}) => const Demo17(),
  "demo18": (BuildContext context, {dynamic arguments}) => const Demo18(),
  "demo19": (BuildContext context, {dynamic arguments}) => const Demo19(),
  "demo20": (BuildContext context, {dynamic arguments}) => const Demo20(),
  "demo21": (BuildContext context, {dynamic arguments}) => const Demo21(),
};

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
      ...baseRoute,
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
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => builder(context, arguments: settings.arguments),
          settings: settings,
        ); //此处将参数传递给ModalRoute
      } else {
        return MaterialPageRoute<dynamic>(builder: builder, settings: settings);
      }
    }
    return null;
  }
}
