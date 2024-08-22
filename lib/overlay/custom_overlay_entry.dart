import 'package:flutter/material.dart';

class CustomOverlayEntry extends OverlayEntry {
  CustomOverlayEntry({
    required this.key,
    required super.builder,
    super.maintainState,
    super.opaque,
  });

  final String key;
}
