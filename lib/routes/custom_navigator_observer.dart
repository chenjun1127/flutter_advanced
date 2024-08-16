import 'package:common_lib/common_lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_advanced/utils/routes_utils.dart';

class CustomNavigatorObserver extends NavigatorObserver {
  static Route<dynamic>? currentRoute;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    final String? routeName = route.settings.name;
    final String? previousRouteName = previousRoute?.settings.name;
    if (routeName != null) {
      RouteController.to.setCurrentRoute(routeName);
      RoutesUtils.addRoutes(route);
      JLogger.i("didPush: route=>$routeName previousRoute=>$previousRouteName");
    }
    currentRoute = route;
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    final String? previousRouteName = previousRoute?.settings.name;
    RoutesUtils.removeRoute(route.settings.name);
    if (previousRouteName != null) {
      RouteController.to.setCurrentRoute(previousRouteName);
    }
    currentRoute = previousRoute;
    JLogger.i("didPop: route=>${route.settings.name} previousRoute=>$previousRouteName");
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    RoutesUtils.removeRoute(route.settings.name);
    JLogger.i("didRemove: route=>${route.settings.name} previousRoute=>${previousRoute?.settings.name}");
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    final String? newRouteName = newRoute?.settings.name;
    RoutesUtils.removeRoute(oldRoute?.settings.name);
    if (newRouteName != null) {
      RouteController.to.setCurrentRoute(newRouteName);
      RoutesUtils.addRoutes(newRoute);
    }
    JLogger.i("didReplace: newRoute=>$newRouteName previousRoute=>${oldRoute?.settings.name}");
  }
}
