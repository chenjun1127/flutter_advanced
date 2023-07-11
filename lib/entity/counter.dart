import 'package:flutter/material.dart';

class Counter {
  final ValueNotifier<int> count = ValueNotifier<int>(0);

  void add() {
    count.value++;
  }
}
