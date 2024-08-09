import 'package:biz_lib/biz_lib.dart';
import 'package:biz_lib/controller/awesome_controller.dart';
export 'package:biz_lib/controller/device_controller.dart';

class CommonBindings {
  static void init() {
    Get.put(AwesomeController(), permanent: true);
    Get.put(DeviceController(), permanent: true);
  }
}
