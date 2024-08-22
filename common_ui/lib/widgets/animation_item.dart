import 'package:flutter/material.dart';

class AnimationItem extends StatefulWidget {
  const AnimationItem({
    Key? key,
    this.child,
    this.scale = 1.2,
    this.beginScale = 1,
  }) : super(key: key);
  final Widget? child;
  final double scale;
  final double beginScale;

  @override
  State<StatefulWidget> createState() => AnimationItemState();
}

class AnimationItemState extends State<AnimationItem> with SingleTickerProviderStateMixin {
  AnimationController? controller;

  @override
  void initState() {
    controller = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    controller?.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: widget.beginScale,
        end: widget.scale,
      ).animate(controller!),
      child: FittedBox(
        fit: BoxFit.fill,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
