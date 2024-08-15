import 'package:common_ui/common_ui.dart';
import 'package:flutter/material.dart';

// 弹出框
Future<bool?> centerDialog({
  required BuildContext context,
  bool barrierDismissible = true, // 是否阻止点击背景关闭
  double width = 480, // 宽度
  double height = 300, // 高度
  String Function()? title, // 标题
  dynamic content = '请输入提示信息...', // 提示类容
  dynamic cancelText, // 取消按钮的文字, 当 cancelText = null 时会隐藏此按钮
  dynamic okText, // 确定按钮的文字, 当 okText = null 时会隐藏此按钮
  void Function()? cancel, // 取消
  void Function()? ok, // 确定
  Key? key,
  Object? arguments, // 参数
  AlignmentGeometry? alignment,
}) {
  Widget _buildButton({required String text, VoidCallback? onTap, Color? color}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        height: 72,
        child: Center(
          child: Text(
            text,
            style: FontStyle.defaultTitle.copyWith(fontSize: 24, color: color ?? const Color.fromRGBO(205, 167, 99, 1)),
          ),
        ),
      ),
    );
  }

  final List<Widget> widgets = <Widget>[];
  // 标题
  if (title is Function) {
    widgets.add(Container(
      padding: const EdgeInsets.fromLTRB(30, 35, 30, 20),
      child: Builder(builder: (BuildContext context) {
        return Text(
          title?.call() ?? "title",
          style: FontStyle.defaultTitle.copyWith(fontSize: 24, color: const Color.fromRGBO(226, 228, 228, 1)),
          textAlign: TextAlign.center,
        );
      }),
    ));
  }
  // 内容
  if (content is String) {
    widgets.add(
      Flexible(
        child: Container(
          alignment: alignment,
          child: Text(
            content,
            style: FontStyle.defaultTitle.copyWith(
              fontSize: 20,
              color: const Color.fromRGBO(226, 228, 228, 1),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  } else if (content is Widget) {
    widgets.add(content);
  }
  // 按钮

  final List<Widget> flexList = <Widget>[];
  if (cancelText != null) {
    flexList.add(
      Expanded(
        child: _buildButton(
          text: cancelText,
          color: Colors.white,
          onTap: () {
            if (cancel == null) {
              if (Navigator.canPop(context)) {
                Navigator.of(context).pop(false);
              }
            } else {
              cancel();
            }
          },
        ),
      ),
    );
  }
  if (okText != null) {
    flexList.add(
      Expanded(
        child: _buildButton(text: okText, onTap: ok, color: const Color.fromRGBO(205, 167, 99, 1)),
      ),
    );
  }
  if (okText != null && cancelText != null) {
    flexList.insert(1, Container(height: 72, width: 1, color: const Color.fromRGBO(255, 255, 255, 0.1)));
  }
  widgets.add(Column(children: <Widget>[
    SizedBox(height: 1, child: Container(color: const Color.fromRGBO(255, 255, 255, 0.1))),
    Flex(direction: Axis.horizontal, children: flexList),
  ]));

  return showDialog<bool>(
    context: context,
    barrierDismissible: barrierDismissible,
    routeSettings: RouteSettings(name: "centerDialog", arguments: arguments),
    builder: (BuildContext context) {
      return AnimatedDialogContainer(
        child: AlertDialog(
          key: key,
          contentPadding: EdgeInsets.zero,
          backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
          elevation: 0,
          // 取消阴影
          content: Container(
            width: width,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(32, 33, 37, 1),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: widgets,
            ),
          ),
        ),
      );
    },
  );
}

class AnimatedDialogContainer extends StatefulWidget {
  const AnimatedDialogContainer({required this.child, super.key});

  final Widget child;

  @override
  _AnimatedDialogContainerState createState() => _AnimatedDialogContainerState();
}

class _AnimatedDialogContainerState extends State<AnimatedDialogContainer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    )..forward();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: _animation, child: widget.child);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
