import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "404",
      style: TextStyle(color: Colors.red),
    );
  }
}
