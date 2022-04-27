import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        itemCount: 20,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.6,
        ),
        itemBuilder: (BuildContext context, int index) {
          return buildItem(index, context);
        },
      ),
    );
  }

  Widget buildItem(int index, BuildContext context) {
    return TextButton(
      onPressed: () {
        if (index == 0) {
          Navigator.pushNamed(context, '/demo1', arguments: <String, dynamic>{"name": "张三"});
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(getColor),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 18)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      ),
      child: Text(index.toString()),
    );
  }

  Color? getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.teal;
  }
}
