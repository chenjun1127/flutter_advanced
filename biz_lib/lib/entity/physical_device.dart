import 'package:biz_lib/entity/base_device.dart';

class PhysicalDevice extends BaseDevice<PhysicalDevice> {
  // PhysicalDevice({String? deviceId, String? deviceName, String? createTime, int? value, int? type, this.desc})
  //     : super(deviceId: deviceId, deviceName: deviceName, createTime: createTime, value: value, type: type);
  PhysicalDevice({super.deviceId, super.deviceName, super.createTime, super.value, super.type, this.desc});

  PhysicalDevice.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
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
  void update({PhysicalDevice? device, bool isNeedRefreshUi = true}) {
    value = device?.value;
    type = device?.type;
    createTime = device?.createTime;
    deviceName = device?.deviceName;
    deviceId = device?.deviceId;
  }
}
