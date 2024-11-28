import 'package:biz_lib/biz_lib.dart';
import 'package:common_ui/styles/styles.dart';
import 'package:common_ui/widgets/animation_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced/utils/color_utils.dart';

class Demo23 extends StatefulWidget {
  const Demo23({super.key});

  static String title = 'Draggable Demo 2';
  static String routeName = 'demo23';

  @override
  State<Demo23> createState() => _Demo23State();
}

class _Demo23State extends State<Demo23> {
  List<MenuData> menus = List<MenuData>.generate(9, (int index) {
    return MenuData('Menu ${index + 1}', ColorUtils.generateRandomColor());
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double itemWidth = constraints.maxWidth / 3; // 3 columns
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
            ),
            itemCount: menus.length,
            itemBuilder: (BuildContext context, int index) {
              return draggableItem(menus[index], itemWidth, itemWidth);
            },
          );
        },
      ),
    );
  }

  Widget draggableItem(MenuData menu, double width, double height) {
    return DraggableItem(
      menu,
      feedbackWidth: width,
      feedbackHeight: height,
      onPressed: (MenuData value) {
        setState(() {
          menus.remove(value);
        });
      },
      exchangeItem: (MenuData moveData, MenuData toData) {
        final int toIndex = menus.indexOf(toData);
        setState(() {
          menus.remove(moveData);
          menus.insert(toIndex, moveData);
        });
      },
      onStartDrag: () {},
      onEndDrag: () {},
    );
  }
}

class DraggableItem extends StatefulWidget {
  const DraggableItem(
    this.item, {
    required this.feedbackWidth,
    required this.feedbackHeight,
    super.key,
    this.exchangeItem,
    this.onStartDrag,
    this.onEndDrag,
    this.onPressed,
  });

  final MenuData item;
  final double feedbackWidth;
  final double feedbackHeight;
  final void Function(MenuData moveData, MenuData toData)? exchangeItem;
  final void Function()? onStartDrag;
  final void Function()? onEndDrag;
  final void Function(MenuData value)? onPressed;

  @override
  State<StatefulWidget> createState() => DraggableItemState();
}

class DraggableItemState extends State<DraggableItem> {
  @override
  Widget build(BuildContext context) {
    final MenuData value = widget.item;
    return LongPressDraggable<MenuData>(
      data: value,
      feedback: AnimationItem(
        child: SizedBox(
          width: widget.feedbackWidth,
          height: widget.feedbackHeight,
          child: BaseItem(value),
        ),
      ),
      onDragStarted: () {
        widget.onStartDrag?.call();
        JLogger.i('=== onDragStarted');
      },
      onDraggableCanceled: (Velocity velocity, Offset offset) {
        JLogger.i('=== onDraggableCanceled');
        widget.onEndDrag?.call();
      },
      onDragCompleted: () {
        JLogger.i('=== onDragCompleted');
        widget.onEndDrag?.call();
      },
      child: DragTarget<MenuData>(
        builder: (BuildContext context, List<MenuData?> candidateData, List<dynamic> rejectedData) {
          return BaseItem(
            value,
            onPressed: () {
              widget.onPressed?.call(value);
            },
          );
        },
        onWillAcceptWithDetails: (DragTargetDetails<MenuData>? moveData) {
          JLogger.i('=== onWillAccept: $moveData ==> $value');

          final bool accept = moveData != null;
          if (accept) {
            widget.exchangeItem?.call(moveData.data, value);
          }
          return accept;
        },
        onAcceptWithDetails: (DragTargetDetails<MenuData> moveData) {
          JLogger.i('=== onAccept: $moveData ==> $value');
        },
        onLeave: (MenuData? moveData) {
          JLogger.i('=== onLeave: $moveData ==> $value');
        },
      ),
    );
  }
}

class MenuData {
  MenuData(this.title, this.color);

  final String title;
  final Color color;
}

class BaseItem extends StatelessWidget {
  const BaseItem(
    this.item, {
    super.key,
    this.onPressed,
  });

  final MenuData item;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: item.color,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              item.title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: FontStyle.defaultTitle.copyWith(
                height: 1.1,
                color: Colors.white,
                fontSize: 18,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
        PositionedDirectional(
          top: 10,
          end: 10,
          child: CupertinoButton(
            onPressed: onPressed,
            padding: const EdgeInsetsDirectional.only(
              start: 20,
              bottom: 20,
            ),
            pressedOpacity: 1,
            child: const Icon(
              Icons.remove_circle_outline_rounded,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
