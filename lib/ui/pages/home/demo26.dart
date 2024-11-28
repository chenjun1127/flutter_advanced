import 'package:common_ui/common_ui.dart';
import 'package:common_ui/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced/overlay/overlay_manager.dart';

class Demo26 extends StatelessWidget {
  const Demo26({super.key});

  static String title = 'Overlay 测试';
  static String routeName = 'demo26';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: _buildButton(() {
          _addOverlay(context, 0);
        }, '添加第1个 Overlay', width: 160, color: Colors.deepOrangeAccent),
      ),
    );
  }

  void _addOverlay(BuildContext context, int index) {
    OverlayManager().insertOverlay(context, 'Overlay-$index', (BuildContext context) {
      return Container(
        color: Colors.black.withOpacity(0.6),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildButton(() {
                _addOverlay(context, index);
              }, '添加1个相同 key 的 Overlay'),
              _buildButton(() {
                _addOverlay(context, 5);
              }, '添加1个不同 key 的 Overlay'),
              _buildButton(_printOverlayList, '查看所有的 Overlay'),
              _buildButton(() {
                _removeOverlayByKey('Overlay-0');
              }, '删除指定 key 的 Overlay'),
              _buildButton(_voidRemoveAllOverlay, '删除所有的 Overlay'),
            ],
          ),
        ),
      );
    });
  }

  void _removeOverlayByKey(String key) {
    OverlayManager().removeOverlay(key);
  }

  void _voidRemoveAllOverlay() {
    OverlayManager().clearOverlays();
  }

  void _printOverlayList() {
    JLogger.i('所有 Overlay:${OverlayManager().entriesMap}');
  }

  Widget _buildButton(VoidCallback onTap, String text, {Color? color, double? width}) {
    return SizedBox(
      width: width ?? 240,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: CustomButton(
          bgColor: color,
          onTap: onTap,
          child: Text(
            text,
            style: FontStyle.defaultTitle.copyWith(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
