import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class CustomSnapshotPainter implements SnapshotPainter {
  const CustomSnapshotPainter({required this.onSnapshot});

  final void Function(ui.Image image, Size sourceSize) onSnapshot;

  @override
  void addListener(ui.VoidCallback listener) {}

  @override
  void dispose() {}

  @override
  bool get hasListeners => false;

  @override
  void notifyListeners() {}

  @override
  void paint(PaintingContext context, ui.Offset offset, ui.Size size, PaintingContextCallback painter) {
    painter(context, offset);
  }

  @override
  void paintSnapshot(
      PaintingContext context, ui.Offset offset, ui.Size size, ui.Image image, Size sourceSize, double pixelRatio) {
    final Rect src = Rect.fromLTWH(0, 0, sourceSize.width, sourceSize.height);
    final Rect dst = Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height);
    final Paint paint = Paint()..filterQuality = FilterQuality.low;
    onSnapshot(image, sourceSize);
    context.canvas.drawImageRect(image, src, dst, paint);
  }

  @override
  void removeListener(ui.VoidCallback listener) {}

  @override
  bool shouldRepaint(covariant CustomSnapshotPainter oldPainter) => false;
}
