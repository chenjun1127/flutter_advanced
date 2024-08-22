import 'package:common_ui/common_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced/ui/pages/getx/getx_page.dart';
import 'package:flutter_advanced/ui/pages/home/home_page.dart';
import 'package:flutter_advanced/ui/pages/setting/setting_page.dart';
import 'package:flutter_advanced/ui/pages/state/state_page.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);
  static const String routeName = 'home';

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  String title = "首页";
  List<ItemBar> itemBarList = <ItemBar>[
    ItemBar("首页", const HomePage(), const Icon(Icons.home)),
    ItemBar("状态管理", const StatePage(), const Icon(Icons.list)),
    ItemBar("GetX", const GetXPage(), const Icon(Icons.label_outline_rounded)),
    ItemBar("设置", const SettingPage(), const Icon(Icons.settings))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: const <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            splashColor: Colors.transparent, // 去掉水波纹效果
            highlightColor: Colors.transparent,
            onPressed: CommonUi.onTap,
          ),
        ],
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
