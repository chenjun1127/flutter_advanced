import 'package:flutter/cupertino.dart';

class BaseContainer extends StatelessWidget {
  const BaseContainer({this.child, EdgeInsets? padding, super.key})
      : padding = padding ?? defaultPadding;
  final Widget? child;
  final EdgeInsets? padding;
  static const EdgeInsets defaultPadding = EdgeInsets.all(10);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: double.infinity,
      child: child ?? const SizedBox.shrink(),
    );
  }
}
