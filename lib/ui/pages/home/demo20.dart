import 'package:flutter/material.dart';
import 'package:flutter_advanced/widgets/circle_button.dart';

class Demo20 extends StatefulWidget {
  const Demo20({super.key});

  static String title = '动画效果';
  static String routeName = 'demo20';

  @override
  State<Demo20> createState() => _Demo20State();
}

class _Demo20State extends State<Demo20> {
  @override
  Widget build(BuildContext context) {
    return Container(alignment: Alignment.center, child: const FadeInFromBottomTextWidget());
  }
}

class FadeInFromBottomTextWidget extends StatefulWidget {
  const FadeInFromBottomTextWidget({super.key});

  @override
  _FadeInFromBottomTextWidgetState createState() => _FadeInFromBottomTextWidgetState();
}

class _FadeInFromBottomTextWidgetState extends State<FadeInFromBottomTextWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _offsetAnimation;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
    _offsetAnimation = Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  void _startAnimation() {
    setState(() {
      _isVisible = true;
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: _startAnimation,
          child: const Text('点击'),
        ),
        const SizedBox(height: 20),
        if (_isVisible)
          SlideTransition(
            position: _offsetAnimation,
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: Container(
                padding: const EdgeInsets.all(20),
                color: Colors.blueAccent,
                child: const Text(
                  'Hello Flutter!',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ),
          )
        else
          Container(),
        const SizedBox(height: 50),
        CircularButton(
          onTap: () {
            _controller.reverse();
          },
        ),
      ],
    );
  }
}
