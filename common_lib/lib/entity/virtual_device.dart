import 'package:common_lib/entity/base_device.dart';
import 'package:mobx/mobx.dart';

class VirtualDevice extends BaseDevice<VirtualDevice> {
  VirtualDevice({String? deviceId, String? deviceName, String? createTime, int? value, int? type, this.desc})
      : super(deviceId: deviceId, deviceName: deviceName, createTime: createTime, value: value, type: type);

  VirtualDevice.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    desc = json['desc'];
  }

  String? desc;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = super.toJson();
    map['desc'] = desc;
    return map;
  }

  @override
  void update({VirtualDevice? device, bool isNeedRefreshUi = true}) {
    if (device != null) {
      toDevice(device);
    }
    if (isNeedRefreshUi) {
      _renew.value++;
    }
  }

  late final Observable<int> _renew = Observable<int>(0);

  int get renew => _renew.value;

  int setUpdate() {
    return _renew.value;
  }

  void toDevice(VirtualDevice newDevice) {
    deviceId = newDevice.deviceId;
    deviceName = newDevice.deviceName;
    createTime = newDevice.createTime;
    value = newDevice.value;
    type = newDevice.type;
  }
}
