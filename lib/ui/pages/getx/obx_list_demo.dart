import 'package:biz_lib/biz_lib.dart';
import 'package:biz_lib/entity/physical_device.dart';
import 'package:flutter/material.dart';

class ObxListDemo extends StatelessWidget {
  const ObxListDemo({super.key});

  static const String routeName = 'obx_list_demo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Getx监听列表对象某一个值更新方法"),
      ),
      body: Container(
        color: Colors.green,
        child: Obx(() {
          final List<PhysicalDevice> list = DeviceController.to.deviceList.toList();
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return _buildItems(list[index], index);
            },
            itemCount: list.length,
          );
        }),
      ),
    );
  }

  void handleChange(String deviceId) {
    JLogger.i("观察UI是否刷新:$deviceId");
    DeviceController.to.updateDeviceById4(deviceId);
  }

  Widget _buildItems(PhysicalDevice device, int index) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.5, color: Color(0xffe5e5e5))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('${device.desc}-序号：$index---value:${device.value}'),
          MaterialButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () {
              handleChange(device.deviceId!);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Text(
                "改变value",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
