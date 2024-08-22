import 'dart:math';
import 'package:flutter/material.dart';

class Demo25 extends StatefulWidget {
  const Demo25({super.key});

  static String title = 'Flow 布局';
  static String routeName = 'demo25';

  @override
  _Demo25State createState() => _Demo25State();
}

class _Demo25State extends State<Demo25> {
  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: <Widget>[FlowCircleMenu()],
    );
  }
}

class FlowCircleMenu extends StatefulWidget {
  const FlowCircleMenu({super.key});

  @override
  State<FlowCircleMenu> createState() => _FlowCircleMenuState();
}

class _FlowCircleMenuState extends State<FlowCircleMenu> with SingleTickerProviderStateMixin {
  late AnimationController animationCircleController;

  @override
  void initState() {
    animationCircleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      upperBound: 100,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: 100,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: ValueListenableBuilder<double>(
                valueListenable: animationCircleController,
                builder: (BuildContext context, double value, Widget? child) {
                  return Flow(
                    delegate: FlowAnimatedCircle(value),
                    children: List<Widget>.generate(
                      5,
                      (int index) => Icon(
                        index.isEven ? Icons.timer : Icons.ac_unit,
                        size: 32,
                        color: Colors.primaries[index % Colors.primaries.length],
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned.fill(
              child: IconButton(
                icon: const Icon(Icons.menu, size: 32),
                onPressed: () {
                  if (animationCircleController.status == AnimationStatus.dismissed) {
                    animationCircleController.forward();
                  } else {
                    animationCircleController.reverse();
                  }
                },
                highlightColor: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationCircleController.dispose();
    super.dispose();
  }
}

class FlowMenuDelegate extends FlowDelegate {
  FlowMenuDelegate({required this.animation}) : super(repaint: animation);
  final Animation<double> animation;

  @override
  void paintChildren(FlowPaintingContext context) {
    double x = 50; //起始位置
    const double y = 20; //横向展开,y不变
    for (int i = 0; i < context.childCount; ++i) {
      x = context.getChildSize(i)!.width * i * animation.value;
      context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
    }
  }

  @override
  bool shouldRepaint(FlowMenuDelegate oldDelegate) {
    return oldDelegate.animation != animation;
  }
}

class FlowAnimatedCircle extends FlowDelegate {
  FlowAnimatedCircle(this.radius);

  final double radius;

  @override
  void paintChildren(FlowPaintingContext context) {
    if (radius == 0) {
      return;
    }
    double x = 0; //开始(0,0)在父组件的中心
    double y = 0;
    for (int i = 0; i < context.childCount; i++) {
      x = radius * cos(i * pi / (context.childCount - 1)); //根据数学得出坐标
      y = radius * sin(i * pi / (context.childCount - 1)); //根据数学得出坐标
      context.paintChild(i, transform: Matrix4.translationValues(x, -y, 0));
    }
  }

  @override
  bool shouldRepaint(FlowAnimatedCircle oldDelegate) => oldDelegate.radius != radius;
}
