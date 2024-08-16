import 'package:common_ui/common_ui.dart';
import 'package:common_ui/iconfont/icon_font.dart';
import 'package:common_ui/styles/styles.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    required this.onTap,
    required this.icon,
    super.key,
    this.text,
    this.iconColor = Colors.white,
    this.fontSize = 20,
    this.padding,
    this.borderRadius,
  });

  final VoidCallback onTap;
  final IconNames icon;
  final Color iconColor;
  final String? text;
  final double fontSize;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: borderRadius ?? BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: IconFont(icon, color: '#${iconColor.value.toRadixString(16)}'),
            ),
            if (text != null) ...<Widget>[
              const SizedBox(width: 8),
              Text(text!, style: FontStyle.defaultTitle.copyWith(color: Colors.white, fontSize: fontSize))
            ],
          ],
        ),
      ),
    );
  }
}
