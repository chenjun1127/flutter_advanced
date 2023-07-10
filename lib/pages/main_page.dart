import 'package:flutter/material.dart';
import 'package:flutter_advanced/content/content.dart';
import 'package:flutter_advanced/home/home.dart';
import 'package:flutter_advanced/setting/setting.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  List<Widget> pageList = <Widget>[
    const Home(),
    const Content(),
    const Setting(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter advanced application"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // 当前菜单下标
        currentIndex: currentIndex,
        // 点击事件,获取当前点击的标签下标
        onTap: (int index) {
          // 改变状态
          setState(() {
            currentIndex = index;
          });
        },
        // 图标大小
        iconSize: 30,
        // 选中图标的颜色
        fixedColor: Colors.blue,
        // 多个标签页的动画效果
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          // 只能是BottomNavigationBarItem的类型
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "分类"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "设置")
        ],
      ),
      body: pageList[currentIndex],
    );
  }
}
