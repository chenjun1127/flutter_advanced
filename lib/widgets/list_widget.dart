import 'package:common_ui/common_ui.dart';
import 'package:common_ui/iconfont/icon_font.dart';
import 'package:flutter/material.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({
    required this.children,
    super.key,
    this.background,
    this.onTap,
    this.initItem,
    this.fontSize,
    this.fontColor,
  });
  final List<String> children;
  final Color? background;
  final int? initItem;
  final double? fontSize;
  final Color? fontColor;
  final Function(String, int)? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color(0xFF141414),
      ),
      margin: const EdgeInsetsDirectional.only(bottom: 30),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              JLogger.i('按下列表:$index');
              onTap?.call(children[index], index);
            },
            child: SizedBox(
              height: 72,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      children[index],
                      style: FontStyle.default400Title.copyWith(
                        fontSize: fontSize ?? 24,
                        color: fontColor ?? Colors.white,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (initItem == index)
                    Container(
                      width: 48,
                      height: 48,
                      margin: const EdgeInsetsDirectional.only(end: 15),
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Center(
                          child: IconFont(
                            IconNames.model_done_1,
                            color: '#${const Color(0xffCDA763).value.toRadixString(16)}',
                            size: 32,
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(height: 1, color: Color(0xFF1E1E1E));
        },
        itemCount: children.length,
      ),
    );
  }
}
