import 'package:flutter/material.dart';
import 'package:flutter_advanced/store/device_store.dart';
import 'package:mobx/mobx.dart';

part 'root_store.g.dart';

//ignore: library_private_types_in_public_api
class RootStore = _RootStore with _$RootStore;

final RootStore rootStore = RootStore();

abstract class _RootStore with Store {
  late DeviceStore deviceStore;

  void initStore({required GlobalKey<NavigatorState> navigatorKey}) {
    deviceStore = DeviceStore();
  }
}
