import 'package:flutter/material.dart';
import 'package:flutter_advanced/entity/device.dart';
import 'package:flutter_advanced/store/device_store.dart';
import 'package:flutter_advanced/store/root_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/src/api/observable_collections.dart';

class Demo14 extends StatefulWidget {
  const Demo14({super.key, this.store});

  final DeviceStore? store;

  @override
  State<Demo14> createState() => _Demo14State();
}

class _Demo14State extends State<Demo14> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("mobx监听列表对象某一个值更新方法"),
      ),
      body: Container(
        color: Colors.green,
        child: Observer(
          builder: (BuildContext context) {
            final List<Device> list = widget.store?.deviceList.toList() ?? <Device>[];
            // 由于在main init中已经初始化声明过deviceStore了，所以也可以用下面的
            // rootStore.deviceStore.deviceList
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Observer(
                  builder: (BuildContext context) {
                    final Device device = list[index];
                    device.setUpdate();
                    return _buildItems(device, index);
                  },
                );
              },
              itemCount: list.length,
            );
          },
        ),
      ),
    );
  }

  void handleChange(String deviceId) {
    print("观察UI是否刷新");
    widget.store?.updateDeviceById(deviceId);
  }

  Widget _buildItems(Device device, int index) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.5, color: Color(0xffe5e5e5))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('序号：$index---value:${device.value}'),
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
