import 'package:biz_lib/biz_lib.dart';
import 'package:common_lib/common_lib.dart';
import 'package:common_ui/generated/locales.g.dart';
import 'package:common_ui/iconfont/icon_font.dart';
import 'package:common_ui/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced/routes/animate_route.dart';
import 'package:flutter_advanced/routes/scale_page_route.dart';
import 'package:flutter_advanced/ui/pages/setting/select_language.dart';
import 'package:flutter_advanced/widgets/center_dialog.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CustomButton(
                icon: IconNames.zan,
                text: "跳转1",
                onTap: _onPressed,
                fontSize: 16,
              ),
              const SizedBox(height: 20),
              CustomButton(
                icon: IconNames.safe,
                text: "跳转2",
                onTap: _toPage,
                fontSize: 16,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 50,
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          ),
          onPressed: () {
            centerDialog(
              width: 800,
              title: () => LocaleKeys.language.tr,
              content: const SelectLanguage(),
              context: context,
            );
          },
          child: Text(LocaleKeys.language.tr),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _toPage() {
    scalePageRoute(
      settings: const RouteSettings(name: "SecondPage"),
      builder: (BuildContext context) {
        return const SecondPage();
      },
      context: context,
    );
  }

  void _onPressed() {
    Navigator.of(context).push(
      ScaleToRouter<void>(
        builder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          return const SecondPage();
        },
        routeSettings: const RouteSettings(name: "SecondPage", arguments: <String, dynamic>{"name": "张三"}),
      ),
    );
  }

  @override
  void initState() {
    JLogger.i("当前路由:${RouteController.to.currentRoute}");
    super.initState();
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('Second Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                JLogger.i("当前路由:${RouteController.to.currentRoute}");
                Navigator.pop(context);
              },
              child: const Text('Go Back'),
            ),
            Text("${ModalRoute.of(context)!.settings.arguments}")
          ],
        ),
      ),
    );
  }
}
