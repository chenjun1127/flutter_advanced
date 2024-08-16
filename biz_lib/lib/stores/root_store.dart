import 'package:biz_lib/stores/device_store.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'root_store.g.dart';

class RootStore = _RootStore with _$RootStore;

final RootStore rootStore = RootStore();

abstract class _RootStore with Store {
  late DeviceStore deviceStore;

  BuildContext get currentContext => navigatorKey.currentContext!; // 当前context
  late GlobalKey<NavigatorState> navigatorKey;

  void initStore({required GlobalKey<NavigatorState> navigatorKey}) {
    this.navigatorKey = navigatorKey;
    deviceStore = DeviceStore();
  }
}
