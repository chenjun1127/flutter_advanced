import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('404 page'),
      ),
      body: const Center(
        child: Text(
          '404',
          style: TextStyle(color: Colors.red, fontSize: 24),
        ),
      ),
    );
  }
}
