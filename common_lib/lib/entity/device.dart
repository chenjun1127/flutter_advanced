import 'package:mobx/mobx.dart';

class Device {
  Device({this.deviceId, this.deviceName, this.createTime, this.value, this.type});

  Device.fromJson(Map<String, dynamic> json) {
    deviceId = json['deviceId'];
    deviceName = json['deviceName'];
    createTime = json['createTime'];
    value = json['value'];
    type = json['type'];
  }

  String? deviceId;
  String? deviceName;
  String? createTime;
  int? value;
  int? type;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['deviceId'] = deviceId;
    map['deviceName'] = deviceName;
    map['createTime'] = createTime;
    map['value'] = value;
    map['type'] = type;
    return map;
  }

  @override
  String toString() {
    return 'Device{deviceId: $deviceId, deviceName: $deviceName, createTime: $createTime, value: $value, type: $type}';
  }

  void update({Device? device, bool? notRefreshUi}) {
    if (device != null) {
      toDevice(device);
    }
    if (notRefreshUi != true) {
      _renew.value++;
    }
  }

  late final Observable<int> _renew = Observable<int>(0);

  int get renew => _renew.value;

  int setUpdate() {
    return _renew.value;
  }

  void toDevice(Device device) {
    deviceId = device.deviceId;
    deviceName = device.deviceName;
    createTime = device.createTime;
    value = device.value;
    type = device.type;
  }
}
