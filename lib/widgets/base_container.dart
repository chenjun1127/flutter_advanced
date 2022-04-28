import 'package:flutter/cupertino.dart';

class BaseContainer extends StatelessWidget {
  const BaseContainer({this.child, EdgeInsets? padding, Key? key})
      : padding = padding ?? defaultPadding,
        super(key: key);
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
