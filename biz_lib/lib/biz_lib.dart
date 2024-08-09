library biz_lib;

import 'package:biz_lib/controller/device_controller.dart';
import 'package:biz_lib/stores/root_store.dart';
import 'package:cj_kit/logger/j_logger.dart';
import 'package:flutter/cupertino.dart';

export 'package:biz_lib/utils/screen_adapt.dart';
export 'package:cj_kit/cj_kit.dart';
export 'package:cj_kit/logger/j_logger.dart';
export 'package:flutter_mobx/flutter_mobx.dart';
export 'package:get/get.dart';
export 'package:provider/provider.dart';
export 'controller/controller.dart';

class BizLib {
  static Future<void> init({required GlobalKey<NavigatorState> navigatorKey}) async {
    JLogger.init();
    rootStore.initStore(navigatorKey: navigatorKey);
    rootStore.deviceStore.createAndProcessDeviceList();
    DeviceController.to.createAndProcessDeviceList();
  }
}
