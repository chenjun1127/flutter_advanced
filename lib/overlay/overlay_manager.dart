import 'package:flutter/cupertino.dart';

import 'package:flutter_advanced/overlay/custom_overlay_entry.dart';
import 'package:flutter_advanced/overlay/overlay_widget.dart';

class OverlayManager {
  factory OverlayManager() => _instance;

  OverlayManager._internal();

  static final OverlayManager _instance = OverlayManager._internal();

  final Map<String, CustomOverlayEntry> _entries = <String, CustomOverlayEntry>{};
  Map<String, CustomOverlayEntry> get entriesMap => _entries;
  /// 插入 CustomOverlayEntry
  void insertOverlay(BuildContext context, String key, WidgetBuilder builder, {int? seconds}) {
    removeOverlay(key); // 插入前先移除同 key 的旧 Entry

    final OverlayState overlay = Overlay.of(context);
    final CustomOverlayEntry entry = CustomOverlayEntry(
      key: key,
      builder: (BuildContext context) => OverlayWidget(
        overlayKey: key,
        builder: builder,
        isSupportAutoClos: seconds != null,
        seconds: seconds ?? 3000,
        removeFunction: removeOverlay,
      ),
    );
    _entries[key] = entry;
    overlay.insert(entry);
  }

  /// 移除特定的 CustomOverlayEntry
  void removeOverlay(String key) {
    final CustomOverlayEntry? entry = _entries[key];
    if (entry != null) {
      entry.remove();
      _entries.remove(key);
    }
  }

  /// 清除所有 CustomOverlayEntry
  void clearOverlays() {
    for (final CustomOverlayEntry entry in _entries.values) {
      entry.remove();
    }
    _entries.clear();
  }

  /// 获取当前插入的 CustomOverlayEntry 数量
  int getOverlayCount() => _entries.length;

  /// 检查 OverlayEntry 是否存在
  bool hasOverlay(String key) {
    return _entries.containsKey(key);
  }

  /// 获取 CustomOverlayEntry
  CustomOverlayEntry? getOverlayEntry(String key) => _entries[key];

  List<CustomOverlayEntry> getOverlayList() => _entries.values.toList();
}
