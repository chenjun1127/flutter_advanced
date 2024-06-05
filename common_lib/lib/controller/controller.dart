import 'package:common_lib/common_lib.dart';
import 'package:common_lib/controller/awesome_controller.dart';
export 'package:common_lib/controller/device_controller.dart';

class CommonBindings {
  static void init() {
    Get.put(AwesomeController(), permanent: true);
    Get.put(DeviceController(), permanent: true);
  }
}
