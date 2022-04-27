import 'package:flutter/material.dart';
import 'package:flutter_advanced/pages/main_page.dart';
import 'package:flutter_advanced/pages/not_found_page.dart';
import 'package:flutter_advanced/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
}
