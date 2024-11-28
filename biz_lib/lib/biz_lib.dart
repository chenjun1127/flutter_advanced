library;

import 'package:biz_lib/stores/root_store.dart';
import 'package:common_lib/common_lib.dart';
import 'package:flutter/cupertino.dart';

export 'package:biz_lib/controller/controller.dart';
export 'package:biz_lib/utils/screen_adapt.dart';
export 'package:common_lib/common_lib.dart';
export 'package:flutter_mobx/flutter_mobx.dart';

class BizLib {
  static Future<void> init({required GlobalKey<NavigatorState> navigatorKey}) async {
    JLogger.init();
    rootStore.initStore(navigatorKey: navigatorKey);
    rootStore.deviceStore.createAndProcessDeviceList();
  }
}
