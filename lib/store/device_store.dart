import 'package:collection/collection.dart';
import 'package:flutter_advanced/entity/device.dart';
import 'package:mobx/mobx.dart';

part 'device_store.g.dart';

//ignore: library_private_types_in_public_api
class DeviceStore = _DeviceStore with _$DeviceStore;

abstract class _DeviceStore with Store {
  @observable
  ObservableMap<String, dynamic> yourMap = ObservableMap<String, dynamic>();

  @computed
  List<dynamic> get mapValues => yourMap.values.toList();

  @observable
  ObservableList<Device> deviceList = ObservableList<Device>();

  @action
  void updateDeviceList(List<Device> list) {
    deviceList.clear();
    deviceList.addAll(list);
  }

  ///此种属性更新，UI视图更新的方式，是通过改变List的长度去更新的，不推荐使用
  @action
  void updateDeviceById2(String deviceId) {
    final Device? device = deviceList.firstWhereOrNull((Device element) => element.deviceId == deviceId);
    if (device != null) {
      final int index = deviceList.indexOf(device);
      final Device currentDevice = device;
      deviceList.remove(device);
      currentDevice.value = 1000;
      deviceList.insert(index, currentDevice);
    }
  }
  ///此种方法通过监听device实现类中int值，来实现widget刷新，缺点，入侵了实体类
  @action
  void updateDeviceById(String deviceId) {
    final Device? device = deviceList.firstWhereOrNull((Device element) => element.deviceId == deviceId);
    device?.value = 1500;
    device?.update();
  }
}
///官方推荐做法，给实体类需求更新的属性添加observable。。。代价过大
// class Device = _Device with _$Device;
//
// abstract class _Device with Store {
//   @observable
//   String name;
//
//   _Device(this.name);
// }