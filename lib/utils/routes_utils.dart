import 'package:biz_lib/biz_lib.dart';
import 'package:biz_lib/stores/root_store.dart';
import 'package:flutter/cupertino.dart';

class RoutesUtils {
  static final Map<String, Route<dynamic>?> _routesMap = <String, Route<dynamic>?>{};

  static void addRoutes(Route<dynamic>? route) {
    if (route == null) {
      return;
    }
    final String? name = route.settings.name;
    if (name != null) {
      _routesMap[name] = route;
    }
  }

  static Route<dynamic>? getRoute(String? name) {
    return _routesMap[name];
  }

  static void removeRoute(String? name) {
    if (name == null) {
      return;
    }
    _routesMap.remove(name);
  }

  static List<String> getRoutesList() {
    return _routesMap.keys.toList();
  }

  static bool isExist(String? routeName) {
    if (routeName == null) {
      return false;
    }
    return getRoutesList().contains(routeName);
  }

  ///跳转界面。
  ///routeName 目标路由。
  static void goPage(String? routeName, {void Function()? push}) {
    if (routeName == null) {
      JLogger.i('目标路由不能为空');
      return;
    }
    if (isExist(routeName)) {
      Navigator.popUntil(rootStore.currentContext, ModalRoute.withName(routeName));
      return;
    }
    if (push == null) {
      Navigator.pushNamed(rootStore.currentContext, routeName);
    } else {
      push.call();
    }
  }
}
