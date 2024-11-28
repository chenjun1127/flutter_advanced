import 'package:common_ui/common_ui.dart';
import 'package:common_ui/iconfont/icon_font.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.onTap,
    this.icon,
    super.key,
    this.text,
    this.iconColor = Colors.white,
    this.fontSize = 20,
    this.padding,
    this.borderRadius,
    this.bgColor,
    this.child,
  });

  final VoidCallback onTap;
  final IconNames? icon;
  final Color iconColor;
  final String? text;
  final double fontSize;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final Widget? child;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bgColor ?? Colors.blue,
          borderRadius: borderRadius ?? BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (icon != null)
              Container(
                alignment: Alignment.center,
                child: IconFont(icon, color: '#${iconColor.value.toRadixString(16)}'),
              ),
            if (text != null) ...<Widget>[
              const SizedBox(width: 8),
              Text(text!, style: FontStyle.defaultTitle.copyWith(color: Colors.white, fontSize: fontSize))
            ],
            child ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
