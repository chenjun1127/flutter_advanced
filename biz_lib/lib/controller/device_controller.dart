import 'dart:math' as math;
import 'package:common_lib/common_lib.dart';
import 'package:biz_lib/biz_lib.dart';
import 'package:biz_lib/entity/physical_device.dart';

class DeviceController extends GetxController {
  static DeviceController get to => Get.find();
  final RxList<PhysicalDevice> deviceList = <PhysicalDevice>[].obs;

  @override
  void onInit() {
    super.onInit();
    JLogger.d('DeviceController onInit');
    createAndProcessDeviceList();
  }

  void updateDeviceList(List<PhysicalDevice> list) {
    deviceList.assignAll(list);
  }

  ///第一种方法更新，UI视图更新的方式，是通过改变List的长度去更新的，不推荐使用
  void updateDeviceById(String deviceId) {
    final int index = deviceList.indexWhere((PhysicalDevice e) => e.deviceId == deviceId);
    if (index > -1) {
      final PhysicalDevice? device = deviceList.firstWhereOrNull((PhysicalDevice e) => e.deviceId == deviceId);
      if (device != null) {
        final int index = deviceList.indexOf(device);
        final PhysicalDevice currentDevice = device;
        deviceList.remove(device);
        currentDevice.value = 1500;
        deviceList.insert(index, currentDevice);
      }
    }
  }

  ///第二种方法更新，UI视图更新的方式，使用 refresh() 方法手动通知更新：
  ///性能：调用 refresh() 会重新构建整个列表，不论你只修改了其中一个对象的一个字段。这在列表很大时，可能会影响性能。
  ///优点：实现简单。
  ///缺点：对于大列表或频繁更新，性能不佳。
  void updateDeviceById2(String deviceId) {
    final PhysicalDevice? device = deviceList.firstWhereOrNull((PhysicalDevice e) => e.deviceId == deviceId);
    device?.value = 1500;
    deviceList.refresh();
  }

  ///第三种方法更新，UI视图更新的方式，替换整个对象，
  ///性能：只会重新构建被替换的对象部分，性能相对较好。
  ///性能较好，只更新受影响的对象。
  ///需要创建新的对象实例。
  void updateDeviceById3(String deviceId) {
    final int index = deviceList.indexWhere((PhysicalDevice e) => e.deviceId == deviceId);
    if (index != -1) {
      deviceList[index] = PhysicalDevice(
        deviceId: deviceList[index].deviceId,
        deviceName: deviceList[index].deviceName,
        createTime: deviceList[index].createTime,
        value: 1500,
        type: deviceList[index].type,
      );
    }
  }

  ///第四种方法更新，UI视图更新的方式，只更新受影响的对象
  ///还有一种方法可以结合局部更新和 GetX 的通知机制，通过扩展 Device 类，使其具备通知机制，但不直接使用 Rx 对象。
  ///这种方法稍微复杂一些，但可以获得更好的性能。
  void updateDeviceById4(String deviceId) {
    final int index = deviceList.indexWhere((PhysicalDevice e) => e.deviceId == deviceId);
    if (index != -1) {
      final PhysicalDevice device = deviceList[index];
      device.update(
        device: PhysicalDevice(
          deviceId: device.deviceId,
          deviceName: device.deviceName,
          createTime: device.createTime,
          value: 1500,
          type: device.type,
        ),
      );
      deviceList[index] = device;
    }
  }

  void createAndProcessDeviceList() {
    final List<PhysicalDevice> list = <PhysicalDevice>[];
    final math.Random random = math.Random();
    for (int i = 0; i < 50; i++) {
      list.add(PhysicalDevice(
        deviceId: '设备$i',
        deviceName: i.toString(),
        type: 0,
        value: random.nextInt(1000),
        createTime: DateTime.now().toIso8601String(),
        desc: '物理设备',
      ));
    }
    updateDeviceList(list);
  }
}
