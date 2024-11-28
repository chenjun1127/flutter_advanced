import 'dart:math';

import 'package:biz_lib/biz_lib.dart';
import 'package:common_ui/widgets/animation_item.dart';
import 'package:flutter/material.dart';

class Demo22 extends StatefulWidget {
  const Demo22({super.key});
  static String title = 'Draggable Demo 1';
  static String routeName = 'demo22';

  @override
  State<StatefulWidget> createState() {
    return Demo22State();
  }
}

class Demo22State extends State<Demo22> {
  late List<DataBean> _targetDataList;
  late DataBean _dragData;

  @override
  void initState() {
    _targetDataList = <DataBean>[];
    _targetDataList.add(DataBean('北', const Offset(140, 0), Colors.green));
    _targetDataList.add(DataBean('西', const Offset(0, 140), Colors.red));
    _targetDataList.add(DataBean('南', const Offset(140, 280), Colors.blue));
    _targetDataList.add(DataBean('东', const Offset(280, 140), Colors.purple));
    _dragData = DataBean(randomTitle(), const Offset(140, 140), Colors.pink);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 400,
        height: 400,
        color: Colors.grey,
        child: Stack(
          children: buildItems(_targetDataList, _dragData),
        ),
      ),
    );
  }

  String randomTitle() {
    final int i = Random().nextInt(_targetDataList.length);
    return _targetDataList[i].title;
  }

  List<Widget> buildItems(List<DataBean> list, DataBean dragData) {
    final List<Widget> items = <Widget>[];
    for (DataBean data in list) {
      items.add(dragTarget(data));
    }

    items.add(draggableItem(_dragData));
    return items;
  }

  // 拖动方
  Widget draggableItem(DataBean data) {
    return Positioned(
      left: data.offset.dx,
      top: data.offset.dy,
      child: Draggable<DataBean>(
        data: data,
        // 要拖动的组件
        feedback: AnimationItem(
          child: buildItem(
            color: data.color.withOpacity(.8),
            child: const Center(
              child: Text(
                '移动中',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
        ),
        childWhenDragging: buildItem(),
        onDragStarted: () {
          // 开始拖动回调
          JLogger.i('=== onDragStarted');
        },
        // 接收失败回调
        onDraggableCanceled: (Velocity velocity, Offset offset) {
          JLogger.i('=== onDraggableCanceled');
        },
        onDragCompleted: () {
          // 接收成功回调
          JLogger.i('=== onDragCompleted');
        },
        // 要传递的数据
        child: baseItem(data, draggable: true),
      ),
    );
  }

  Widget buildItem({Widget? child, Color? color}) {
    return Container(width: 120, height: 120, color: color ?? Colors.red, child: child);
  }

  // 接收方
  Widget dragTarget(DataBean data) {
    JLogger.i('data==$data');
    return Positioned(
      left: data.offset.dx,
      top: data.offset.dy,
      child: DragTarget<DataBean>(
        //展示的组件
        builder: (BuildContext context, List<DataBean?> candidateData, List<dynamic> rejectedData) {
          return baseItem(data, draggable: false);
        },
        //返回是否接收 参数为Draggable的data 方向相同则允许接收
        onWillAcceptWithDetails: (Object? acceptData) {
          if (acceptData is DataBean) {
            JLogger.i('=== onWillAccept: ${acceptData.title}----${data.title}');
            return acceptData.title.compareTo(data.title) == 0;
          }
          return false;
        },

        onAcceptWithDetails: (DragTargetDetails<DataBean> acceptData) {
          //接收方法
          JLogger.i('=== onAccept: ${acceptData.data.title}==>${data.title}');
          setState(() {
            //修改数据进行重绘
            // 交换颜色 并生成随机方向
            final int index = _targetDataList.indexOf(data);
            final Color tmpColor = data.color;
            data.color = acceptData.data.color;
            _targetDataList.remove(data);
            _targetDataList.insert(index, data);
            _dragData.title = randomTitle();
            _dragData.color = tmpColor;
          });
        },
      ),
    );
  }

  Widget baseItem(DataBean data, {required bool draggable}) {
    final String title = draggable ? '往"${data.title}"走' : data.title;
    return buildItem(
      color: data.color,
      child: Center(
        child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }
}

// 要传递的数据
class DataBean {
  DataBean(this.title, this.offset, this.color);

  String title;
  Offset offset;
  Color color;

  @override
  String toString() {
    return 'DataBean{title: $title, offset: $offset, color: $color}';
  }
}
