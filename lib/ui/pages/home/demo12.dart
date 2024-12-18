import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';

class Demo12 extends StatefulWidget {
  const Demo12({super.key});

  static String title = '获取列表可视Item/转跳到指定Index一';
  static String routeName = 'demo12';

  @override
  State<Demo12> createState() => _Demo12State();
}

class _Demo12State extends State<Demo12> {
  final Map<int, dynamic> _keys = <int, dynamic>{};
  final ScrollController scrollController = ScrollController();

  /// 给整个ListView设置Rect信息获取能力
  final GlobalKey<RectGetterState> listViewKey = RectGetter.createGlobalKey();

  @override
  Widget build(BuildContext context) {
    final RectGetter listView = RectGetter(
      key: listViewKey,
      child: ListView.builder(
        controller: scrollController,
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          /// 给每个build出来的item设置Rect信息获取能力
          /// 并将用于获取Rect的key及index存入map中备用
          _keys[index] = RectGetter.createGlobalKey();
          return RectGetter(
            key: _keys[index],
            child: Container(
              color: Colors.primaries[index % Colors.primaries.length],
              child: SizedBox(
                width: 100,

                /// 利用index创建伪随机高度的条目
                height: 50.0 + ((27 * index) % 15) * 3.14,
                child: Center(
                  child: Text('$index'),
                ),
              ),
            ),
          );
        },
      ),
    );
    final TextEditingController textCtl = TextEditingController(
      text: '0',
    );

    return Column(
      children: <Widget>[
        Expanded(
          child: NotificationListener<ScrollUpdateNotification>(
            onNotification: (ScrollUpdateNotification notification) {
              getVisible();
              return true;
            },
            child: listView,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              width: 100,
              height: 50,
              child: TextField(
                controller: textCtl,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                jumpTo(int.parse(textCtl.text));
              },
              child: const Text('JUMP'),
            )
          ],
        ),
      ],
    );
  }

  List<int> getVisible() {
    /// 先获取整个ListView的rect信息，然后遍历map
    /// 利用map中的key获取每个item的rect,如果该rect与ListView的rect存在交集
    /// 则将对应的index加入到返回的index集合中
    final Rect? rect = RectGetter.getRectFromKey(listViewKey);
    if (rect == null) {
      return <int>[];
    }
    final List<int> items = <int>[];
    _keys.forEach((int index, dynamic key) {
      final Rect? itemRect = RectGetter.getRectFromKey(key);
      if (itemRect != null && !(itemRect.top > rect.bottom || itemRect.bottom < rect.top)) {
        items.add(index);
      }
    });

    /// 这个集合中存的就是当前处于显示状态的所有item的index
    return items;
  }

  void scrollLoop(int target, Rect listRect) {
    final int first = getVisible().first;
    final bool direction = first < target;
    Rect? rect;
    if (_keys.containsKey(target)) {
      rect = RectGetter.getRectFromKey(_keys[target]);
    }
    if (rect == null || (direction ? rect.bottom < listRect.top : rect.top > listRect.bottom)) {
      double offset = scrollController.offset + (direction ? listRect.height / 2 : -listRect.height / 2);
      offset = offset < 0.0 ? 0.0 : offset;
      offset = offset > scrollController.position.maxScrollExtent ? scrollController.position.maxScrollExtent : offset;
      scrollController.jumpTo(offset);
      Timer(Duration.zero, () {
        scrollLoop(target, listRect);
      });
      return;
    }

    scrollController.jumpTo(scrollController.offset + rect.top - listRect.top);
  }

  void jumpTo(int target) {
    final List<int> visible = getVisible();
    if (visible.contains(target)) {
      return;
    }

    final Rect? listRect = RectGetter.getRectFromKey(listViewKey);
    scrollLoop(target, listRect!);
  }
}
