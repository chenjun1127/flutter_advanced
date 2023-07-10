import 'package:flutter/material.dart';
import 'package:flutter_advanced/pages/main_page.dart';
import 'package:flutter_advanced/pages/not_found_page.dart';
import 'package:flutter_advanced/routes/routes.dart';
import 'package:flutter_advanced/store/root_store.dart';

void main() {
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: Routes.onGenerateRoute,
      home: const MainPage(),
      onUnknownRoute: (_) {
        return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
          return const NotFoundPage();
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    rootStore.initStore(navigatorKey: navigatorKey);
  }
}
