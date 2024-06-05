import 'package:common_lib/common_lib.dart';
import 'package:common_lib/entity/virtual_device.dart';
import 'package:common_lib/stores/root_store.dart';
import 'package:flutter/material.dart';

class Demo11 extends StatefulWidget {
  const Demo11({super.key});

  @override
  State<Demo11> createState() => _Demo11State();
}

class _Demo11State extends State<Demo11> {
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
            final List<VirtualDevice> list = rootStore.deviceStore.deviceList.toList();
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Observer(
                  builder: (BuildContext context) {
                    final VirtualDevice device = list[index];
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
    JLogger.i("观察UI是否刷新:$deviceId");
    rootStore.deviceStore.updateDeviceById(deviceId);
  }

  Widget _buildItems(VirtualDevice device, int index) {
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

  @override
  void initState() {
    super.initState();
    JLogger.i("initState:111111111111");
  }
}
