import 'package:biz_lib/biz_lib.dart';
import 'package:common_ui/common_ui.dart';
import 'package:common_ui/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced/fix/fix.dart';
import 'package:flutter_advanced/routes/custom_navigator_observer.dart';
import 'package:flutter_advanced/routes/routes.dart';
import 'package:flutter_advanced/ui/home_layout.dart';
import 'package:flutter_advanced/ui/not_found_page.dart';

void main() {
  CjKit.runApp(
    app: const MyApp(),
    preRun: () async {
      WidgetsFlutterBinding.ensureInitialized();
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: <SystemUiOverlay>[]);
      // 调整Flutter中图片缓存的最大大小,图片缓存的最大数量为200张图,图片缓存的最大字节大小为40MB。
      PaintingBinding.instance.imageCache.maximumSize = 200;
      PaintingBinding.instance.imageCache.maximumSizeBytes = 40 << 20;
      FPSUtils().addTimingsCallback();
      await BizLib.init(navigatorKey: navigatorKey);
      CommonUi.setOnTap(() => JLogger.i('回调测试-controller是否注册:${Get.isRegistered<DeviceController>()}'));
    },
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: fixDesktopPlatformDragDevice(),
      theme: ThemeData(primarySwatch: Colors.blue),
      initialBinding: BindingsBuilder<void>(() {
        Get.put(RouteController(), permanent: true);
        Get.put(AwesomeController(), permanent: true);
        Get.put(DeviceController(), permanent: true);
        Get.put(LanguageController(), permanent: true);
      }),
      onGenerateRoute: Routes.onGenerateRoute,
      initialRoute: HomeLayout.routeName,
      home: const HomeLayout(),
      locale: const Locale(LanguageConst.simpleChinese),
      // 默认语言
      fallbackLocale: const Locale(LanguageConst.english),
      // 后备语言
      translationsKeys: AppTranslation.translations,
      // 直接使用翻译数据: ,
      onUnknownRoute: (_) => MaterialPageRoute<dynamic>(builder: (BuildContext context) => const NotFoundPage()),
      navigatorObservers: <NavigatorObserver>[
        CustomNavigatorObserver(),
      ],
    );
  }
}
