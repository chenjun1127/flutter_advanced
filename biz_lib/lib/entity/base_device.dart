abstract class BaseDevice<T extends BaseDevice<T>> {
  BaseDevice({this.deviceId, this.deviceName, this.createTime, this.value, this.type});

  BaseDevice.fromJson(Map<String, dynamic> json) {
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

  void update({T? device, bool isNeedRefreshUi = true});
}
