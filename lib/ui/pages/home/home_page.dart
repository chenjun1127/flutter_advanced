import 'package:flutter/cupertino.dart' hide Page;
import 'package:flutter_advanced/routes/routes.dart';
import 'package:flutter_advanced/widgets/page_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListPage(
      children: getRoutes(),
    );
  }
}
