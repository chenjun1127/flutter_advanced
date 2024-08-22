import 'dart:ui' as ui;

import 'package:common_lib/common_lib.dart';
import 'package:common_ui/styles/styles.dart';
import 'package:common_ui/widgets/animation_item.dart';
import 'package:common_ui/widgets/custom_snapshot.dart';
import 'package:drag_anim/drag_anim.dart';
import 'package:drag_anim/drag_anim_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced/utils/color_utils.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Demo24 extends StatefulWidget {
  const Demo24({super.key});

  static String title = 'Draggable Demo 3';
  static String routeName = 'demo24';

  @override
  State<Demo24> createState() => _Demo24State();
}

class _Demo24State extends State<Demo24> {
  List<ItemData> items = List<ItemData>.generate(40, (int index) {
    return ItemData('Item ${index + 1}', ColorUtils.generateRandomColor(), const Uuid().v4());
  });
  Axis scrollDirection = Axis.horizontal;
  final Map<String, ui.Image> imageMap = <String, ui.Image>{};
  final SnapshotController controller = SnapshotController(allowSnapshotting: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Demo24.title),
        actions: <Widget>[
          CupertinoButton(
            child: Text('完成', style: FontStyle.defaultTitle.copyWith(color: Colors.white, fontSize: 18)),
            onPressed: () {
              JLogger.i("点击拖动排序完成items:$items");
              JLogger.i("imageMap:$imageMap");
            },
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: DragAnimNotification(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          scrollDirection: scrollDirection,
          child: DragAnim<ItemData>(
            draggingWidgetOpacity: 0,
            scrollDirection: scrollDirection,
            buildItems: (List<Widget> children) {
              return StaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: children,
              );
            },
            dataList: items,
            items: (ItemData element, DragItems dragItems) {
              Widget getContent() {
                return dragItems(
                  DragConfig(
                    isDart: true,
                    child: SnapshotWidget(
                      controller: controller,
                      painter: CustomSnapshotPainter(onSnapshot: (ui.Image image, Size sourceSize) {
                        imageMap[element.id] = image;
                      }),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: element.color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          element.title,
                          style: FontStyle.defaultTitle.copyWith(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        items.remove(element);
                      });
                    },
                  ),
                );
              }

              // mainAxisCellCount: 2 表示该网格项在主轴（通常是垂直方向）上占据了 2 行的高度。
              // crossAxisCellCount: 1 表示该网格项在交叉轴（通常是水平方向）上占据了 1 列的宽度。
              return StaggeredGridTile.count(
                mainAxisCellCount: 2,
                crossAxisCellCount: 1,
                key: ValueKey<String>(element.id),
                child: getContent(),
              );
            },
            buildFeedback: (ItemData element, Widget child, Size? size) {
              return DefaultTextStyle(
                style: FontStyle.defaultTitle.copyWith(decoration: TextDecoration.none),
                child: AnimationItem(
                  scale: 1.05,
                  child: SizedBox(
                    width: size?.width,
                    height: size?.height,
                    child: Builder(builder: (_) {
                      final ui.Image? image = imageMap[element.id];
                      if (image != null) {
                        return RawImage(image: image);
                      }
                      return child;
                    }),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ItemData {
  ItemData(this.title, this.color, this.id);

  final String title;
  final Color color;
  final String id;

  @override
  String toString() {
    return 'ItemData{title: $title, color: $color, id: $id}';
  }
}

class DragConfig extends StatelessWidget {
  const DragConfig({
    required this.child,
    this.isShowDeleted = true,
    this.isDart = false,
    super.key,
    this.onPressed,
    this.absorbing = true,
  });

  final bool isShowDeleted;
  final Widget child;
  final bool isDart;
  final VoidCallback? onPressed;
  final bool absorbing;

  @override
  Widget build(BuildContext context) {
    if (!isDart) {
      return child;
    }
    return Stack(
      children: <Widget>[
        PositionedDirectional(
          top: 10,
          end: 10,
          bottom: 0,
          start: 0,
          child: AbsorbPointer(
            absorbing: absorbing,
            child: child,
          ),
        ),
        PositionedDirectional(
          top: 0,
          end: 0,
          child: GestureDetector(
            onTap: () {
              onPressed?.call();
            },
            child: Container(
              alignment: Alignment.center,
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                color: Color(0xFFFF6057),
                shape: BoxShape.circle,
              ),
              child: Container(
                width: 14,
                height: 2.5,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
