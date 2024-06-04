import 'package:flutter/material.dart';
import 'package:flutter_advanced/ui/content/content.dart';
import 'package:flutter_advanced/ui/home/home.dart';
import 'package:flutter_advanced/ui/setting/setting.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  String title = "首页";
  List<ItemBar> itemBarList = <ItemBar>[
    ItemBar("首页", const Home(), const Icon(Icons.home)),
    ItemBar("状态管理", const Content(), const Icon(Icons.list)),
    ItemBar("设置", const Setting(), const Icon(Icons.settings))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // 当前菜单下标
        currentIndex: currentIndex,
        // 点击事件,获取当前点击的标签下标
        onTap: (int index) {
          // 改变状态
          setState(() {
            currentIndex = index;
            title = itemBarList[index].title;
          });
        },
        // 图标大小
        iconSize: 30,
        // 选中图标的颜色
        fixedColor: Colors.blue,
        // 多个标签页的动画效果
        type: BottomNavigationBarType.fixed,
        items: itemBarList.map((ItemBar e) => BottomNavigationBarItem(icon: e.icon, label: e.title)).toList(),
      ),
      body: itemBarList[currentIndex].page,
    );
  }
}

class ItemBar {
  ItemBar(this.title, this.page, this.icon);

  final String title;
  final Widget page;
  final Icon icon;
}
